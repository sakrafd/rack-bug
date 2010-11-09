#
module Rack
  class Bug

    class MemoryPanel < Panel

      def before(env)
        @original_memory = `ps -o rss= -p #{$$}`.to_i
      end

      def after(env, status, headers, body)
        @total_memory = `ps -o rss= -p #{$$}`.to_i
        @memory_increase = @total_memory - @original_memory
      end

      def heading
        "&nbsp;#{humanize(@memory_increase)} KB &#916;; #{humanize(@total_memory)} KB total"
      end

      def has_content?
        false
      end

      private

      def humanize(memory)
        memory.to_s.gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,')
      end
    end
  end
end
