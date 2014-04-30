module Puppet::Parser::Functions
  newfunction(:hiera_resources, :type => :statement) do |args|
    raise Puppet::Error, "hiera_resources requires 1 argument; got #{args.length}" if args.length != 1
    resources = function_hiera_array([args[0], {}])

    dup_check = {}
    resources.each do |res|
      title = res.delete("name")
      type_name = res.delete("puppet_type")

      # Avoid duplicated resources. Don't create resources already seen
      if dup_check[title] == type_name
        debug "hiera_resources: Duplicated resource, title: #{title}, type_name: #{type_name}. Not creating resource"
      else
        dup_check[title] = type_name
        params = { title => res }
        debug "hiera_resources: type_name: #{type_name}. params: #{params}"
        function_create_resources([type_name, params])
      end
    end
  end
end
