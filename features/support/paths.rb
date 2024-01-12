module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  def path_to(page_name)
    case page_name

    when /^upload/ then "films/new"
    when /^registration/ then "users/new"
    when /^login/ then "login"
    when /^user profile/ then "users/profile" # this doesnt really exist. its actually 'users/user_id'
    when /^home/ then "home"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
      # page_name =~ /^the (.*) page$/
      # path_components = $1.split(/\s+/)
      # self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
              "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  # Returns a regex that matches against a potential page
  def regex_for_path(page_name)
    case page_name

    when /^upload/ then %r{/films/new/}
    when /^registration/ then %r{/users/new}
    when /^login/ then %r{/login}
    when /^users profile/ then %r{/users/\d+}
    when /^home/ then %r{/home}
    else %r{.*}

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    end
  end
end

World(NavigationHelpers)
