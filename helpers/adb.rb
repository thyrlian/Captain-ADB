require_relative 'io_stream'

module CaptainADB
  module ADB    
    def list_devices
      list = `adb devices`
      devices = list.split("\n")[1..-1].inject([]) do |devices, device|
        devices.push(device.split("\t"))
      end
    end

    def uninstall_app(package_name)
      result = `adb uninstall #{package_name}`.chomp
      if result == 'Success'
        'Uninstalled successfully.'
      elsif result == 'Failure'
        'Can not uninstall, app does not exist.'
      else # - waiting for device -
        'Please check your device connection.'
      end
    end

    def clear_app(package_name)
      result = `adb shell pm clear #{package_name}`.chomp
      if result == 'Success'
        'Cleared app\'s data & cache successfully.'
      elsif result == 'Failed'
        'Can not clear, app does not exist.'
      else # - waiting for device -
        'Please check your device connection.'
      end
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
  end
end