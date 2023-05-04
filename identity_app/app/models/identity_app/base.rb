module IdentityApp
  module ActiveRecord
    class Base
      def readonly?
        ENV['APP_NAME'] != IdentityApp::APP_NAME
      end
    end
  end
end
