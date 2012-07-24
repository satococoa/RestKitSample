class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    get_user
    true
  end

  def get_user
    objectMapping = RKObjectMapping.mappingForClass(GithubUser.class)
    objectMapping.mapKeyPath('login', toAttribute:'login')
    objectMapping.mapKeyPath('email', toAttribute:'email')
    objectMapping.mapKeyPath('name', toAttribute:'name')

    manager = RKObjectManager.objectManagerWithBaseURLString('https://api.github.com')
    manager.loadObjectsAtResourcePath('/users/satococoa', objectMapping:objectMapping, delegate:self)
  end

  def objectLoader(objectLoader, didLoadObjects:objects)
    puts "\e[32m objectLoader:didLoadObjects:\e[0m"
    user = objects.objectAtIndex(0)
    NSLog("User Loaded / login: %@, email: %@, name: %@", user.login, user.email, user.name)
  end

  def objectLoader(objectLoader, didFailWithError:error)
    puts "\e[31m objectLoader:didFailWithError:\e[0m"
    NSLog("Encountered an error: %@", error)
  end
end
