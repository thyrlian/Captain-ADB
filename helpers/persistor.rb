module CaptainADB
  class Persistor
    class << self
      def get_var(name)
        if list_vars.include?(name.intern)
          class_variable_get("@@#{name.to_s}".intern)
        else
          raise(RuntimeError, "No such variable defined: #{name.to_s}", caller)
        end
      end
      
      def set_var(name, value)
        class_variable_set("@@#{name.to_s}".intern, value)
      end
      
      def list_vars
        class_variables.map { |var| var.to_s.gsub(/@@/, '').intern }
      end
    end
  end
end