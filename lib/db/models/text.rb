  class Agenda < Sequel::Model

    def parsed_title
      Orgmode::Parser.new(self[:content]).in_buffer_settings['TITLE']
    end

    def sample_text
      org = Orgmode::Parser.new(self[:content])
      if self[:title] and not self[:title].empty?
        self[:title]
      elsif org.in_buffer_settings['TITLE'] and not org.in_buffer_settings['TITLE'].empty?
        org.in_buffer_settings['TITLE']
      else
        org.headlines.first.headline_text
      end
    end

    def to_html
      Orgmode::Parser.new(self[:content]).to_html
    end
  end
