import UIKit

//Фабричный метод

// общий интерфейс для создания объектов,  чтобы подклассы могли изменить тип создаваемых обектов
// объявляем общий интерфейс (протокол)
protocol Magazine {
    var magazineType : String {get}
    var magazineAdress : String {get}
    
    func open()
    func close()
}

class ProductMagazine: Magazine {
    var magazineType: String = "Продуктовый"
    
    var magazineAdress: String = "Ленина 36"
    
    func open() {
        print ("Продуктовый открыт по будням")
    }
    
    func close() {
       print ("закрыто в выходные дни")
    }
}
    
    class FishMagazine: Magazine {
        var magazineType: String = "Рыбная лавка"
        
        var magazineAdress: String = "Ленина 37"
        
        func open() {
            print ("Рыбная лавка работает без выходных")
        }
        
        func close() {
            print ("закрыто в праздничные дни")
        }
}

// список возможных типов
enum magazineTypes {
    case ProductMagazine, FishMagazine
}

// фабрика
class MagazineFactory {
    
    func createMagazine(type: magazineTypes) -> Magazine {
        switch type {
        case .FishMagazine: return FishMagazine()
        case .ProductMagazine: return ProductMagazine()
        }
        
    }
}

//пример использования

//массив с магазинами
var magazineList = [Magazine]()

// функция создания объектов с помощью фабрики
func newMagazine(magazineType: magazineTypes  ) {
    let newMagazine = MagazineFactory.init().createMagazine(type:magazineType)
    magazineList.append(newMagazine)
    
}
// создание магазинов разных типов
newMagazine(magazineType: .FishMagazine)
newMagazine(magazineType: .FishMagazine)
newMagazine(magazineType: .ProductMagazine)

// вывод режимов работы магазинов
for i in magazineList {
 i.open()
}

//абстрактная фабрика - создание связанных объектов без прривязки к конкретным классам

// задаем тип объектов через интерфейс (критерии для связанных объектов)
protocol Table {
    var name: String {get}
    var type: String {get}
}
protocol Chair {
    var name: String {get}
    var type: String {get}
}
protocol Floor {
    var name: String {get}
    var type: String {get}
}
//создаем конкретные классы
class KitchenTable: Table {
    var name: String = "Стол"
    
    var type: String = "Стол для кухни"
    
}

class KitchenChair: Chair {
    var name: String = "Стул"
    
    var type: String = "Стул для кухни"
    
}

class KitchenFloor: Floor {
    var name: String = "Ламинат"
    
    var type: String = "Ламинат для кухни"
    
}


class RoomTable: Table {
    var name: String = "Стол"
    
    var type: String = "Стол для комнаты"
    
}

class RoomChair: Chair {
    var name: String = "Стул"
    
    var type: String = "Стул для комнаты"
    
}

class RoomFloor: Floor {
    var name: String = "Ламинат"
    
    var type: String = "Ламинат для комнаты"
    
}
//описываем абстрактную фабрику
protocol AbstractFactory {
    func createTable()-> Table
    func createChair()-> Chair
    func createFloor()-> Floor
    
}
// создаем фабрику
class KitchenFactory:AbstractFactory {
    func createTable() -> Table {
        print ("Стол для кухни создан")
        return KitchenTable()
    }
    
    func createChair() -> Chair {
        print ("Стул для кухни создан")
        return KitchenChair()
    }
    
    func createFloor() -> Floor {
        print ("Пол для кухни создан")
        return KitchenFloor()
    }
}

class RoomFactory:AbstractFactory {
    func createTable() -> Table {
        print ("Стол для комнаты создан")
        return RoomTable()
    }
    
    func createChair() -> Chair {
        print ("Стул для комнаты создан")
        return RoomChair()
    }
    
    func createFloor() -> Floor {
        print ("Пол для комнаты создан")
        return RoomFloor()
    }
}

func createKitchen() {
     _ = KitchenFactory().createTable()
     _ = KitchenFactory().createChair()
     _ =  KitchenFactory().createFloor()
}
func createRoom() {
    _ = RoomFactory().createTable()
    _ = RoomFactory().createChair()
    _ = RoomFactory().createFloor()
}
//создаем объекты без привязки к конкретным классам
createKitchen()
createRoom()

// Прототип - для глубокого копирования

class Person {
    var name: String
    init(name:String) {self.name = name}
    func clone() -> Person {
        return Person(name: self.name)
    }
}
var Bob = Person(name: "Bob")
//через метод clone  копируем объект
var Ann = Bob.clone()
print (Ann.name)
//проверяем ссылку на объект чтобы убедиться что объекты разные
print (Bob === Ann)

//Singleton  доступ к единственному экземпляру

class Story {
    static let single = Story()
    var storyName = "Monster Story"
    var autor = "Bob"
    
}
//single это ссылка на единственный объект
print (Story.single.autor)

// строитель - создание объекта отдельными частями (только нужными шагами)
// продукт
class Car {
    var wheels : String?
    var body : String?
    var doors : String?
    var color : String?
}
//интерфейс строителя - объявляет шаги общие для всех видов объектов
protocol CarBuilder {
 func setWheels()
 func setbody()
 func setDoors()
 func setColor()
 func buildNewCar() -> Car
}
// конкретные строители
class SportCarBuilder:CarBuilder{
   
    var newCar : Car = Car()
    
    func setWheels() {
        newCar.wheels = "Спортивные колеса"
    }
    
    func setbody() {
        newCar.body = "Облегченный кузов"
    }
    
    func setDoors() {
       newCar.doors = "Облегченные двери"
    }
    
    func setColor() {
        newCar.color = "Красный цвет"
    }
    
    func buildNewCar() -> Car {
        return newCar
    }
}
    
    class ClassicCarBuilder:CarBuilder{
        var newCar:Car = Car()
        
        func setWheels() {
            newCar.wheels = "Обычные колеса"
        }
        
        func setbody() {
            newCar.body = "Классический кузов"
        }
        
        func setDoors() {
            newCar.doors = "Классические  двери"
        }
        
        func setColor() {
            newCar.color = "Черный цвет"
        }
        
        func buildNewCar() -> Car {
            return newCar
        }
}
// директор
class Director {
    func createCar (buildCar : CarBuilder) -> Car {
        buildCar.setWheels()
        buildCar.setbody()
        buildCar.setDoors()
        buildCar.setColor()
        return buildCar.buildNewCar()
    }
}

// проверка
let SportCarmaster = SportCarBuilder()
let NewDirector = Director ()

//Директор получает объект конкретного строителя от клиента (приложения)
NewDirector.createCar(buildCar: SportCarmaster)


