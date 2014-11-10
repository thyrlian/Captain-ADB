require_relative 'io_stream'

module CaptainADB
  module ADB
    def list_devices
      list = `adb devices`
      devices = list.split("\n")[1..-1].inject([]) do |devices, device|
        devices.push(device.split("\t").first)
      end
    end
    
    def list_devices_with_details
      devices = list_devices.inject([]) do |devices, device_sn|
        device = {}
        device['sn'] = device_sn
        ['manufacturer', 'brand', 'model'].each do |property|
          cmd = "adb -s #{device_sn} shell getprop | grep 'ro.product.#{property}'"
          regex = /#{property}\]:\s+\[(.*?)\]$/
          property_value = regex.match(`#{cmd}`.chomp)
          device[property] = property_value ? property_value[1] : 'N/A'
        end
        devices.push(device)
      end
    end
    
    def list_installed_packages(device_sn = nil)
      cmd = PrivateMethods.synthesize_command('adb shell pm list packages', device_sn)
      `#{cmd}`.split("\n").map! { |pkg| pkg.gsub(/^package:/, '').chomp }
    end
    
    def take_a_screenshot(dir, device_sn = nil)
      dir = dir.gsub(/\/$/, '') + '/'
      system("mkdir -p #{dir}")
      timestamp = Time.now.strftime('%Y%m%d_%H%M%S_%L')
      file_path = "#{dir}screenshot_#{timestamp}.png"
      cmd = 'adb shell screencap -p'
      cmd = PrivateMethods.synthesize_command(cmd, device_sn)
      data = `#{cmd}`.encode('ASCII-8BIT', 'binary').gsub(/\r\n/, "\n")
      begin
        File.open(file_path, 'w') { |f| f.write(data) }
      rescue Exception => e
        return [false, {'message' => e.message, 'backtrace' => e.backtrace}]
      end
      return [true, {'file_path' => file_path}]
    end
    
    def get_app_info(package_name, device_sn = nil)
      cmd = PrivateMethods.synthesize_command("adb shell dumpsys package #{package_name}", device_sn)
      result = `#{cmd}`.chomp.match(/Packages:(.*|\n?)+\z/)[0].gsub(/Packages:\r?\n/, '').gsub(/^.*Package.*\r?\n/, '')
      info = []
      number_of_leading_spaces = result.match(/^(\s+)/)[1].size
      result.gsub(/^[^=]+:.*$/, '').gsub(/^[^=:]*$/, '').gsub(/\s+(\w+=)/, '→\1').gsub(/\r?\n/, '').split('→').reject(&:empty?).map(&:chomp).each do |x|
        pair = x.split('=')
        key = pair.first
        value = pair.last
        if value.match(/\[.*\]/)
          info.push({key => value.split(/\[|\]|\s|,/).reject(&:empty?)})
        else
          info.push({key => value})
        end
      end
      result.gsub(/\r\n^\s{#{number_of_leading_spaces + 1},}/, ' ').scan(/^\s{#{number_of_leading_spaces}}([^=]*?):\s+(.*)/).each do |x|
        info.push({x.first => x.last.chomp.split(/\s+/)})
      end
      info
    end

    def uninstall_app(package_name, device_sn = nil)
      cmd = PrivateMethods.synthesize_command("adb uninstall #{package_name}", device_sn)
      result = `#{cmd}`.chomp
      if result == 'Success'
        return true
      elsif result == 'Failure'
        return false
      else
        return false
      end
    end

    def clear_app(package_name, device_sn = nil)
      cmd = PrivateMethods.synthesize_command("adb shell pm clear #{package_name}", device_sn)
      result = `#{cmd}`.chomp
      if result == 'Success'
        return true
      elsif result == 'Failed'
        return false
      else
        return false
      end
    end
    
    # Precondition: device needs to be rooted
    def change_language(language, country, device_sn = nil)
      cmd = PrivateMethods.synthesize_command("adb shell \"su -c 'setprop persist.sys.language #{language}; setprop persist.sys.country #{country}; stop; sleep 5; start'\"", device_sn)
      `#{cmd}`
    end
    
    def is_device_rooted?(device_sn = nil)
      cmd = PrivateMethods.synthesize_command("adb shell 'which su; echo $?'", device_sn)
      exit_status = `#{cmd}`.split(/\r\n/)[1].to_i
      return exit_status == 0
    end

    def start_monkey_test(package_name, numbers_of_events = 50000)
      # `adb shell monkey -p #{package_name} -v #{numbers_of_events}`
      cmd = "adb shell monkey -p #{package_name} -v #{numbers_of_events}"
      IoStream.redirect_command_output(cmd) do |line|
        puts line
      end
    end
    
    def stop_monkey_test
      `adb shell ps | awk '/com\.android\.commands\.monkey/ { system("adb shell kill " $2) }'`
    end
    
    class PrivateMethods
      class << self
        def synthesize_command(cmd, device_sn)
          if device_sn.nil?
            cmd
          else
            # -s <specific device>
            cmd.gsub(/^adb\s/, "adb -s #{device_sn} ")
          end
        end
      end
    end
  end
end