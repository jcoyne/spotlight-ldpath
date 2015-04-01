module Spotlight::Resources
  class LdpathHarvester < Spotlight::Resource

    def self.can_provide? res
      false
    end

    def to_solr
      []
    end

    def harvest_resources
      items.each do |x|
        h = convert_subject_to_solr_hash(x)
        Spotlight::Resources::Upload.create(
          remote_url_url: h[:url],
          data: h,
          exhibit: exhibit
        ) if h[:url]
      end
    end

    def items
      data[:items].split("\n")
    end

    def program
      @program ||= Ldpath::Program.parse program_data
    end

    def program_data
      data[:program]
    end

    def convert_subject_to_solr_hash x
      h = program.evaluate(x)
      create_sidecars_for h.keys - ['title']
      create_sidecars_for :source_url

      
      solr_hash = {}
      solr_hash[title_field] = h['title']
      solr_hash[:source_url] = x
            
      content.each_with_object(solr_hash) do |(key, value), hash|
        hash[exhibit_custom_fields[key].field] = value
      end
    end
    
    def title_field
      Spotlight::Engine.config.upload_title_field || exhibit.blacklight_config.index.title_field
    end

    def create_sidecars_for *keys
      missing = keys - exhibit.custom_fields.map { |x| x.label }

      missing.each do |k|
        exhibit.custom_fields.create! label: k
      end.tap { @exhibit_custom_fields = nil }
    end

    def exhibit_custom_fields
      @exhibit_custom_fields ||= exhibit.custom_fields.each_with_object({}) do |value, hash|
        hash[value.label] = value
      end
    end

  end
end