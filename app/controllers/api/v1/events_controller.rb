module Api
  module V1
    class EventsController < ActionController::Base
      def create
        @events = {
          'events_registry_add' => {
            klass: Events::RegistryAdd,
            args: [:url, :our_url],
          },
          'events_registry_destroy' => {
            klass: Events::RegistryDestroy,
            args: [:registry_id],
          },
          'events_rule_add' => {
            klass: Events::RuleAdd,
            args: [:name, :src, :namespace_id, :namespace_name, :rule_type],
          },
          'events_rule_destroy' => {
            klass: Events::RuleDestroy,
            args: [:rule_id],
          },
          'events_namespace_add' => {
            klass: Events::NamespaceAdd,
            args: [:name],
          },
          'events_namespace_destroy' => {
            klass: Events::NamespaceDestroy,
            args: [:namespace_id],
          },
          'events_git_repository_add' => {
            klass: Events::GitRepositoryAdd,
            args: [:name, :url],
          },
          'events_git_repository_destroy' => {
            klass: Events::GitRepositoryDestroy,
            args: [:git_repository_id],
          },
          'events_trial_add' => {
            klass: Events::TrialAdd,
            args: [:rule_id, :version],
          },
          'events_trial_table_add' => {
            klass: Events::TrialTableAdd,
            args: [:rule_id, :name, :content],
          },
        }
      
        @event = make
        render(json: { url: api_v1_event_path(id: @event.public_id) })
      end

      def show
        @event = Events::Event.where(public_id: params['id']).first
        render(json: EventSerializer.as_json(@event))
      end

      private

      def make
        k = params.keys.drop_while { |k| !@events.key?(k) }.first
        args = params.require(k).permit(*@events[k][:args])
        @events[k][:klass].create(args.merge(public_id: UUID.generate))
      end
    end
  end
end
