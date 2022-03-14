import Foundation

func convertResponseDatatoUserData (responseData: ResponseData) -> (UserData?) {

      let about: String = responseData.about
      let lastOnline: String = responseData.lastOnline
      let age: String = String(responseData.age)
      let authkey: String = responseData.authkey
      let id: Int = responseData.id
      let name: String =  responseData.name
      var sport = String()
      var goals = String()
      var city = String()
      var gender = String()
      
    switch responseData.gender {
                   case 0: gender = "Любой"
                   case 1: gender = "Мужской"
                   case 2: gender = "Женский"
                       
                   default: print("Не удается записать пол")
                    gender = ""
                   }
                   
    switch responseData.cityId {
                   case 3: city = "Москва"
                   case 4: city = "Санкт Петербург"
                       
                   default: print("Не удается записать город")
                city = ""
                   }
                   
    switch responseData.sportId {
                   case 1: sport = "Теннис"
                   case 2: sport = "Футбол"
                   case 3: sport = "Баскетбол"
                   case 4: sport = "Воллейбол"
                       
                   default: print("Не удается записать спорт")
        sport = ""
                   }
                   
    switch responseData.goals {
                   case 2: goals = "Тренера"
                   case 3: goals = "Учеников"
                   case 5: goals = "Напарника"
                   case 11: goals = "Команду"
                        
                   default: print("Не удается записать цели")
                        goals = ""
                  }
    
      
      let userData = UserData(about: about, lastOnline: lastOnline, age: age, authkey: authkey, id: id, name: name, sport: sport, goals: goals, city: city, gender: gender)
      
      return userData
  }

func convertUserDataToRequestData (userData: UserData) -> ( RequestData?) {
    let userId: Int = Int(userData.id)
    let about: String = userData.about
    let age: Int = Int(userData.age) ?? 0
    let authkey: String = userData.authkey
    
    var sport = Int()
    var goals = Int()
    var city = Int()
    var sex = Int()
    
    switch userData.sport {
                       case "Футбол" : sport = 2
                       case "Баскетбол" : sport = 3
                       case "Теннис" : sport = 1
                       case "Воллейбол" : sport = 4
    
                   default: print("Cпорт не определен")
                   }
    
    switch userData.goals {
                       case "Тренера" : goals = 2
                       case "Учеников" : goals = 3
                       case "Напарника" : goals = 5
                       case "Команду" : goals = 11
    
                       default: print("Цель не определена")
                   }
    switch userData.gender {
                       case "Любой" : sex = 0
                       case "Мужской" : sex = 1
                       case "Женский" : sex = 2
               
                       default: print("Не удается записать пол")
           }
           
    switch userData.city {
                       case "Москва" : city = 3
                       case "Санкт Петербург" : city = 4
                           
                       default: print("Не удается записать город")
           }
    
    let requestData = RequestData(about: about, userId: userId, authkey: authkey, sex: sex, age: age, sport: sport, goals: goals, city: city)
    
    return requestData
}
func convertSearchRequestDataToSearchSettingsData (requestData: SearchRequestData) -> (SearchSettingsData?) {
    
    var id = Int()
    var authkey = String()
    var cityIndex = Int()
    var sportIndex = Int()
    var goalIndex = Int()
    var genderIndex = Int()
        
    
    switch requestData.city {
                   case 3: cityIndex = 0 // Москва
                   case 4: cityIndex = 1 // Спб
                       
                   default: print("Не удается записать пол")
                   }
                   
    switch requestData.sport {
                   case 1: sportIndex = 2 // Теннис
                   case 2: sportIndex = 0 // Футбол
                   case 3: sportIndex = 1 // Баскетбол
                   case 4: sportIndex = 3 // Воллейбол
                       
                   default: print("Не удается записать город")
                   }
                   
    switch requestData.goals {
                   case 2: goalIndex = 2  //Тренера
                   case 3: goalIndex = 3 //Учеников
                   case 5: goalIndex = 0  //Напарника
                   case 11: goalIndex = 1 //Команду
                       
                   default: print("Не удается записать спорт")
                   }
                   
    switch requestData.sex {
                    case 0: genderIndex = 0  //Любой
                    case 1: genderIndex = 1  //Мужской
                    case 2: genderIndex = 2  //Женский
                        
                    default: print("Не удается записать цели")
    }
    id = requestData.id
    authkey = requestData.authkey
    
    let searchSettingsData = SearchSettingsData(cityIndex: cityIndex, sportIndex: sportIndex, goalIndex: goalIndex, genderIndex: genderIndex, id: id, authkey: authkey)
    
    return searchSettingsData
    }



func convertSearchSettingsDataToSearchRequestData (searchSettingsData: SearchSettingsData) -> (SearchRequestData?) {

     var authkey = String()
        var id = Int()
        var sport = Int()
        var goals = Int()
        var city = Int()
        var sex = Int()
    
    switch searchSettingsData.cityIndex{
                   case 0: city = 3 // Москва
                   case 1: city = 4 // Спб
                       
                   default: print("Не удается записать пол")
                   }
                   
    switch searchSettingsData.sportIndex {
                   case 2: sport = 1 // Теннис
                   case 0: sport = 2 // Футбол
                   case 1: sport = 3 // Баскетбол
                   case 3: sport = 4 // Воллейбол
                       
                   default: print("Не удается записать город")
                   }
                   
    switch searchSettingsData.goalIndex {
                   case 2: goals = 2  //Тренера
                   case 3: goals = 3 //Учеников
                   case 0: goals = 5  //Напарника
                   case 1: goals = 11 //Команду
                       
                   default: print("Не удается записать спорт")
                   }
                   
    switch searchSettingsData.genderIndex {
                    case 0: sex = 0  //Любой
                    case 1: sex = 1  //Мужской
                    case 2: sex = 2  //Женский
                        
                    default: print("Не удается записать цели")
    }
    id = searchSettingsData.id
    authkey = searchSettingsData.authkey
    let searchRequestData = SearchRequestData(authkey: authkey, id: id, sport: sport, goals: goals, city: city, sex: sex)
    
    return searchRequestData

}

func convertResponseDatatoUserData1 (responseData: SearchResponseData) -> (UserData1) {
       
       let about: String = responseData.about
       let lastOnline: String = responseData.lastOnline
       let age: String = String(responseData.age)
       let id: Int = responseData.id
       let name: String =  responseData.name
       var sport = String()
       var goals = String()
       var city = String()
       var gender = String()
       
    switch responseData.gender {
                   case 0: gender = "Любой"
                   case 1: gender = "Мужской"
                   case 2: gender = "Женский"
                       
                   default: print("Не удается записать пол")
                    gender = ""
                   }
                   
    switch responseData.cityId {
                   case 3: city = "Москва"
                   case 4: city = "Санкт Петербург"
                       
                   default: print("Не удается записать город")
                city = ""
                   }
                   
    switch responseData.sportId {
                   case 1: sport = "Теннис"
                   case 2: sport = "Футбол"
                   case 3: sport = "Баскетбол"
                   case 4: sport = "Воллейбол"
                       
                   default: print("Не удается записать спорт")
        sport = ""
                   }
                   
    switch responseData.goals {
    case 2: goals = "Тренера"
    case 3: goals = "Учеников"
    case 5: goals = "Напарника"
    case 11: goals = "Команду"
        
    default: print("Не удается записать цели")
        goals = ""
    }
           
       let searchResponseData =  UserData1(about: about, lastOnline: lastOnline, age: age, id: id, name: name, sport: sport, goals: goals, city: city, gender: gender)!
       
       return searchResponseData
   
   }
func convertResponseDatatoUserData2 (responseData: EditProfileResponseData) -> (UserData1) {

    let about: String = responseData.about
    let lastOnline: String = responseData.lastOnline
    let age: String = String(responseData.age)
    let id: Int = responseData.id
    let name: String =  responseData.name
    var sport = String()
    var goals = String()
    var city = String()
    var gender = String()
    
    switch responseData.gender {
                   case 0: gender = "Любой"
                   case 1: gender = "Мужской"
                   case 2: gender = "Женский"
                       
                   default: print("Не удается записать пол")
                    gender = ""
                   }
                   
    switch responseData.cityId {
                   case 3: city = "Москва"
                   case 4: city = "Санкт Петербург"
                       
                   default: print("Не удается записать город")
                city = ""
                   }
                   
    switch responseData.sportId {
                   case 1: sport = "Теннис"
                   case 2: sport = "Футбол"
                   case 3: sport = "Баскетбол"
                   case 4: sport = "Воллейбол"
                       
                   default: print("Не удается записать спорт")
        sport = ""
                   }
                   
    switch responseData.goals {
                    case 2: goals = "Тренера"
                    case 3: goals = "Учеников"
                    case 5: goals = "Напарника"
                    case 11: goals = "Команду"
                        
                    default: print("Не удается записать цели")
        goals = ""
    }
    
    let editProfileResponseData =  UserData1(about: about, lastOnline: lastOnline, age: age, id: id, name: name, sport: sport, goals: goals, city: city, gender: gender)!
    
    return editProfileResponseData

}
