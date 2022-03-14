import Foundation

class ErrorHandler {
private init() {}
static let shared = ErrorHandler()
    
    enum DataProcessingError: Error {
        case dataToJson
        case jsonToResponse
    }
    static func errorHandler(errorCode: String) -> (errorDescription: String, errorAlert:String?) {
        
    var errorDescription = String()
    var errorAlertText: String?
        
        switch errorCode {
    case "c1": errorDescription = "Пользователь с данным ID не найден"
               errorAlertText = "Произошла ошибка, попробуйте еще раз"
    case "c2": errorDescription = "Неверный authkey"
               errorAlertText = "Произошла ошибка, попробуйте еще раз"
    case "l1": errorDescription = "Пользователь с таким номером не найден"
               errorAlertText = "Пользователь с таким номером не найден"
    case "l2": errorDescription = "Неправильный пароль"
               errorAlertText = "Неправильный пароль"
    case "m1": errorDescription = "Переписки с этим пользователем нет"
    case "m2": errorDescription = "Сообщение с таким id не найдено"
    case "m3" : errorDescription = "Диалогов у аккаунта нет"
    case "m4": errorDescription = "Пытается отметить прочитанным сообщение отправленное не ему"
    case "s0": errorDescription = "Оффсет поиска больше количества найденных пользователей "
               errorAlertText = "Произошла ошибка, попробуйте еще раз"
    case "r4": errorDescription = "Аккаунт с этим номером уже существует"
               errorAlertText = "Аккаунт с этим номером уже существует"
    case "u1": errorDescription = "Пользователь с данным id не найден"
               errorAlertText = "Произошла ошибка, попробуйте еще раз"
    
    default:
        errorDescription = "Не удается записать ошибку"
    }
    return (errorDescription, errorAlertText)
    
    }
    enum NetworkingError: Error {
        case jsonCastingError
    }
}
