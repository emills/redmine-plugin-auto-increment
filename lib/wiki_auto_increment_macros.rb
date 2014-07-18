module WikiAutoIncrement
  class Macros
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
      desc "Increments a number with the first call returning '1' Examples:\n\n" +
      "  !{{auto_increment}} -- Will return 1 on first use, 2 on second use, etc." +
      "  !{{auto_increment(foobar)}} -- Will associate the incremented value with the name 'foobar'. Allows for multiple increments on the same page." +
      "  !{{auto_increment(operation)}} -- Performs specified operation against current value. (+ => Add One, - => Subtract One, = => Current Value, ! => Reset To 1)" +
      "  !{{auto_increment(foobar, operation)}} -- Combination of previous two examples."
      macro :auto_increment do |obj, args|
        @values ||= {}
        WikiAutoIncrement::Macros.doAutoIncrement(@values, args)
      end

      desc "Increment the lower case alphabet with the first call returning 'a'. When 'z' is reached the counter will wrap to 'a'." +
      "  !{{auto_increment_lower}} -- Will return a on first use, b on second use, etc." +
      "  !{{auto_increment_lower(foobar)}} -- Will associate the incremented value with the name 'foobar'. Allows for multiple increments on the same page." +
      "  !{{auto_increment_lower(operation)}} -- Performs specified operation against current value. (+ => Add One, - => Subtract One, = => Current Value, ! => Reset To 1)" +
      "  !{{auto_increment_lower(foobar, operation)}} -- Combination of previous two examples."
      macro :auto_increment_lower do |obj, args|
        @values_alpha_lower ||= {}
        WikiAutoIncrement::Macros.doAlphaAutoIncrement(ALPHA_LOWER, @values_alpha_lower, args)
      end

      desc "Alias of !{{auto_increment_alpha_lower}}"
      macro :auto_increment_alpha do |obj, args|
        @values_alpha_lower ||= {}
        WikiAutoIncrement::Macros.doAlphaAutoIncrement(ALPHA_LOWER, @values_alpha_lower, args)
      end

      desc "Increment the upper case alphabet with the first call returning 'A'. When 'Z' is reached the counter will wrap to 'A'." + 
      "  !{{auto_increment_upper}} -- Will return A on first use, B on second use, etc." +
      "  !{{auto_increment_upper(foobar)}} -- Will associate the incremented value with the name 'foobar'. Allows for multiple increments on the same page." +
      "  !{{auto_increment_upper(operation)}} -- Performs specified operation against current value. (+ => Add One, - => Subtract One, = => Current Value, ! => Reset To 1)" +
      "  !{{auto_increment_upper(foobar, operation)}} -- Combination of previous two examples."
      macro :auto_increment_upper do |obj, args|
        @values_alpha_upper ||= {}
        WikiAutoIncrement::Macros.doAlphaAutoIncrement(ALPHA_UPPER, @values_alpha_upper, args)
      end
    end

  end
end