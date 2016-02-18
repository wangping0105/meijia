module NonullSerializerable
  extend ActiveSupport::Concern

  included do
    class_attribute :stringify_keys, :integerify_keys, :floatify_keys, :objectify_keys

    def attributes
      origin = super
      @all_attrs = origin.map{|k,v| k}
      origin.merge!(stringify_attributes(origin))
      origin.merge!(floatify_attributes(origin))
      origin.merge!(integerify_attributes(origin))
      origin.merge!(objectify_attributes(origin))

      origin
    end

    private
    def stringify_attributes(attrs)
      if self.class.stringify_keys.present?
        self.class.stringify_keys.each_with_object({}) do |name, hash|
          if @all_attrs.include? name
            _origin = attrs[name]
            #待办 _origin = Emojimmy.token_to_emoji(_origin) if _origin.class == String
            hash[name] = _origin.nil? ? "" : _origin
          end
        end
      else
        {}
      end
    end

    def floatify_attributes(attrs)
      if self.class.floatify_keys.present?
        self.class.floatify_keys.each_with_object({}) do |name, hash|
          if @all_attrs.include? name
            _origin = attrs[name]
            hash[name] = _origin.nil? ? 0.0 : _origin
          end
        end
      else
        {}
      end
    end

    def integerify_attributes(attrs)
      if self.class.integerify_keys.present?
        self.class.integerify_keys.each_with_object({}) do |name, hash|
          if @all_attrs.include? name
            _origin = attrs[name]
            hash[name] = _origin.nil? ? 0 : _origin
          end
        end
      else
        {}
      end
    end

    def objectify_attributes(attrs)
      if self.class.objectify_keys.present?
        self.class.objectify_keys.each_with_object({}) do |name, hash|
          if @all_attrs.include? name
            _origin = attrs[name]
            hash[name] = _origin.nil? ? {} : _origin
          end
        end
      else
        {}
      end
    end
  end

  module ClassMethods
  end
end
