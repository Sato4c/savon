require "savon/logger"

module Savon
  class Options

    def initialize(options = {})
      @options = {}
      assign options
    end

    def [](option)
      @options[option]
    end

    def []=(option, value)
      self.send(option, value)
    end

    def include?(option)
      @options.key? option
    end

    private

    def assign(options)
      options.each do |option, value|
        self.send(option, value)
      end
    end

  end

  class GlobalOptions < Options

    def self.new_with_defaults(options = {})
      defaults = {
        :encoding         => "UTF-8",
        :soap_version     => 1,
        :logger           => Logger.new,
        :hooks            => Class.new { def fire(*) yield end }.new,
        :pretty_print_xml => false,
        :raise_errors     => false
      }

      new defaults.merge(options)
    end

    # Location of the local or remote WSDL document.
    def wsdl(wsdl_address)
      @options[:wsdl] = wsdl_address
    end

    # SOAP endpoint.
    def endpoint(endpoint)
      @options[:endpoint] = endpoint
    end

    # Target namespace.
    def namespace(namespace)
      @options[:namespace] = namespace
    end

    # The namespace identifer.
    def namespace_identifier(identifier)
      @options[:namespace_identifier] = identifier
    end

    # Proxy server to use for all requests.
    def proxy(proxy)
      @options[:proxy] = proxy
    end

    # A Hash of HTTP headers.
    def headers(headers)
      @options[:headers] = headers
    end

    # Open timeout in seconds.
    def open_timeout(open_timeout)
      @options[:open_timeout] = open_timeout
    end

    # Read timeout in seconds.
    def read_timeout(read_timeout)
      @options[:read_timeout] = read_timeout
    end

    # The encoding to use. Defaults to "UTF-8".
    def encoding(encoding)
      @options[:encoding] = encoding
    end

    # The global SOAP header. Expected to be a Hash.
    def soap_header(header)
      @options[:soap_header] = header
    end

    # Sets whether elements should be :qualified or unqualified.
    # If you need to use this option, please open an issue and make
    # sure to add your WSDL document for debugging.
    def element_form_default(element_form_default)
      @options[:element_form_default] = element_form_default
    end

    # Can be used to change the SOAP envelope namespace identifier.
    # If you need to use this option, please open an issue and make
    # sure to add your WSDL document for debugging.
    def env_namespace(env_namespace)
      @options[:env_namespace] = env_namespace
    end

    # Changes the SOAP version to 1 or 2.
    # If you need to use this option, please open an issue and make
    # sure to add your WSDL document for debugging.
    def soap_version(soap_version)
      @options[:soap_version] = soap_version
    end

    # Whether or not to raise SOAP fault and HTTP errors.
    def raise_errors(raise_errors)
      @options[:raise_errors] = raise_errors
    end

    # The logger to use. Defaults to a Savon::Logger instance.
    def logger(logger)
      @options[:logger] = logger
    end


    # Whether to pretty print request and response XML log messages.
    def pretty_print_xml(pretty_print_xml)
      @options[:pretty_print_xml] = pretty_print_xml
    end

    # Used by Savon to store the last response to pass
    # its cookies to the next request.
    def last_response(last_response)
      @options[:last_response] = last_response
    end

    def hooks(hooks)
      @options[:hooks] = hooks
    end
  end

  class LocalOptions < Options

    # The SOAP message to send. Expected to be a Hash or a String.
    def message(message)
      @options[:message] = message
    end

    # SOAP message tag (formerly known as SOAP input tag). If it's not set, Savon retrieves the name from
    # the WSDL document (if available). Otherwise, Gyoku converts the operation name into an XML element.
    def message_tag(message_tag)
      @options[:message_tag] = message_tag
    end

    # Value of the SOAPAction HTTP header.
    def soap_action(soap_action)
      @options[:soap_action] = soap_action
    end

    # The SOAP request XML to send. Expected to be a String.
    def xml(xml)
      @options[:xml] = xml
    end

  end
end
