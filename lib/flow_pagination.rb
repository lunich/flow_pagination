require 'will_paginate/view_helpers/link_renderer'

module FlowPagination

  # FlowPagination renderer for (Mislav) WillPaginate Plugin
  class LinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

    # Render flow navigation
    def to_html
      flow_pagination = ''

      if self.current_page < self.last_page

        @template_params = @template.params.clone
        @template_params.delete(:controller)
        @template_params.delete(:action)

        @url_params = {
          :controller => @template.controller_name,
          :action     => @template.action_name,
        }

        symbolized_update @url_params, @template_params if @template.request.get?
        symbolized_update @url_params, @options[:params] if @options[:params]
        symbolized_update @url_params, { :page => self.next_page }

        flow_pagination = @template.link_to(
          @template.t('flow_pagination.button', :default => 'More'),
          @url_params,
          :remote => true,
          :method => @template.request.request_method)

      end

      @template.content_tag(:div, flow_pagination, :id => 'flow_pagination')

    end

    protected
      # Get current page number
      def current_page
        @collection.current_page
      end

      # Get last page number
      def last_page
        @collection.total_pages
      end

      # Get next page number
      def next_page
        @collection.next_page
      end

  end

end
