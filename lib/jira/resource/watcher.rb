module JIRA
  module Resource
    class WatcherFactory < JIRA::BaseFactory # :nodoc:
    end

    class Watcher < JIRA::Base
      belongs_to :issue

      nested_collections true

      def self.endpoint_name
        'watchers'
      end

      def self.all(client, options = {})
        issue = options[:issue]
        raise ArgumentError, 'parent issue is required' unless issue

        path = "#{issue.self}/#{endpoint_name}"
        response = client.get(path)
        json = parse_json(response.body)
        json['watchers'].map do |watcher|
          issue.watchers.build(watcher)
        end
      end
    end
  end
end
