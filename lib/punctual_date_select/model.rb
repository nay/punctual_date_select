module PunctualDateSelect
  module DateHash
    def year
      get_integer_of :year
    end
    def month
      get_integer_of :month
    end
    alias_method :mon, :month
    def day
      get_integer_of :day
    end
    def to_date
      if year.nil? || month.nil? || day.nil?
        nil
      else
        begin
          Date.new(year, month, day)
        rescue
          nil
        end
      end
    end
    def to_s(*args)
      date = to_date
      date ? date.to_s(*args) : ""
    end

    private
    def get_integer_of(key)
      self[key].blank? ? nil : self[key].to_i # This plugin also extends select_year that if this method returns nil it goes well.
    end
  end

  module Model
    module ClassMethods
      def punctual_date_column(*args)
        args.each do |column_name|
          cast_method = :"cast_#{column_name}_if_possible"
          before_validation cast_method

          define_method cast_method do
            casted_date = send(column_name).try(:to_date)
            send("#{column_name}=", casted_date) if casted_date
          end

          validation_method = :"validate_#{column_name}_is_casted"
          validate validation_method

          define_method validation_method do
            errors.add(column_name, :invalid) if send(column_name) && !send(column_name).kind_of?(Date) && !send(column_name).kind_of?(Time)
          end

          define_method "#{column_name}=" do |value|
            self[column_name] = (value.kind_of?(Hash) && !value.values.any?{|t| !t.blank?}) ? nil : value
            if value.kind_of?(Hash) && !value.kind_of?(PunctualDateSelect::DateHash)
              class << value
                include PunctualDateSelect::DateHash
              end
            end
            self[column_name]
          end

          private cast_method, validation_method
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
ActiveRecord::Base.send(:include, PunctualDateSelect::Model)
