require 'reports/base'
require 'html-conditional-comment'

module Reports
  class ConditionalComments < Base
    class Visitor < HtmlConditionalComment::Visitors::Visitor
      attr_accessor :metrics

      def initialize()
        @metrics = {}
      end

      def visit_HtmlConditionalComment_Nodes_Browser(subject)
        browser = subject.feature
        browser = "#{browser} #{subject.version_vector.string}" if subject.version_vector.string
        @metrics[browser] ||= 0
        @metrics[browser] += 1
      end

      def visit_HtmlConditionalComment_Nodes_Nodes(subject)
        subject.each{|node| node.accept(self)}
      end

      def visit_branch(subject)
        subject.left.accept(self)
        subject.right.accept(self)
      end
      alias_method :visit_HtmlConditionalComment_Nodes_Condition, :visit_branch
      alias_method :visit_HtmlConditionalComment_Nodes_Or, :visit_branch
      alias_method :visit_HtmlConditionalComment_Nodes_And, :visit_branch

      def visit_child(subject)
        subject.child.accept(self)
      end
      alias_method :visit_HtmlConditionalComment_Nodes_Not, :visit_child
      alias_method :visit_HtmlConditionalComment_Nodes_Equal, :visit_child
      alias_method :visit_HtmlConditionalComment_Nodes_LessThan, :visit_child
      alias_method :visit_HtmlConditionalComment_Nodes_LessThanEqual, :visit_child
      alias_method :visit_HtmlConditionalComment_Nodes_GreaterThan, :visit_child
      alias_method :visit_HtmlConditionalComment_Nodes_GreaterThanEqual, :visit_child

      def visit_noop(subject); end
      alias_method :visit_HtmlConditionalComment_Nodes_Html, :visit_noop
      alias_method :visit_HtmlConditionalComment_Nodes_True, :visit_noop
      alias_method :visit_HtmlConditionalComment_Nodes_False, :visit_noop
    end


    def create(email)
      part = find_part(email.mail_message(), Mime[:html])
      return if part.nil?

      #Find most common browser
      visitor = Visitor.new()

      begin
        nodes = HtmlConditionalComment.parse(part.decoded())
        nodes.accept(visitor)
      rescue
        Rails.logger.warn($!.inspect())
        return
      end
      browser = visitor.metrics.max_by{|browser| browser[1]}
      return if browser.nil?()

      report = email.report_strings.find_or_initialize_by({:key => self.class.name})
      report.value = browser[0]
      report.save!()
      report
    end
  end
end
