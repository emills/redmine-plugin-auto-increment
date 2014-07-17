module Macros
  class AutoIncrement
    DEFAULT_VALUE_NAME = 'DEFAULT'
    OPERATION_MAPPING = { "+" => :increment, '-' => :decrement, '=' => :current, '!' => :reset }
    DEFAULT_OPERATION = :increment
    ALPHA_LOWER = ('a'..'z').to_a
    ALPHA_UPPER = ('A'..'Z').to_a

    def self.doAutoIncrement(values, args)
      value_name = DEFAULT_VALUE_NAME
      operation = DEFAULT_OPERATION

      # Parse Arguments
      if args.size > 1
        value_name = args.first.to_s
        operation = OPERATION_MAPPING[args[1]] || DEFAULT_OPERATION
      elsif args.size == 1
        arg = args.first.to_s
        operation = OPERATION_MAPPING[arg]
        unless operation
          value_name = arg
          operation = DEFAULT_OPERATION
        end
      end

      # Get Current Value Or Initial
      value = values[value_name] || 0

      # Perform Operation
      case operation
      when :increment
        value = value.next
      when :decrement
        value = value.pred
      when :reset
        value = 1
      end

      # Store Value
      values[value_name] = value

      return value
    end

    def self.doAlphaAutoIncrement(alpha, values, args)
      increment = doAutoIncrement(values, args)
      i = (increment % alpha.length) - 1
      return alpha[i]
    end

    Redmine::WikiFormatting::Macros.register do
      desc ""
      macro :auto_increment do |obj, args|
        @values ||= {}
        Macros::AutoIncrement.doAutoIncrement(@values, args)
      end

      desc ""
      macro :auto_increment_alpha do |obj, args|
        @values_alpha_lower ||= {}
        Macros::AutoIncrement.doAlphaAutoIncrement(ALPHA_LOWER, @values_alpha_lower, args)
      end
      
      desc ""
      macro :auto_increment_lower do |obj, args|
        @values_alpha_lower ||= {}
        Macros::AutoIncrement.doAlphaAutoIncrement(ALPHA_LOWER, @values_alpha_lower, args)
      end


      desc ""
      macro :auto_increment_upper do |obj, args|
        @values_alpha_upper ||= {}
        Macros::AutoIncrement.doAlphaAutoIncrement(ALPHA_UPPER, @values_alpha_upper, args)
      end
    end

  end
end