import UIKit

var greeting = "Hello, playground"

//AnyObject now we can make delegate as weak property
protocol EngineerDelegate: AnyObject {
    func tasksHasEnded()
}

class Engineer {
    weak var delegate: EngineerDelegate?

    var tasks: Int = 0 {
        didSet {
            if tasks == 0 {
                delegate?.tasksHasEnded()
            }
        }
    }

    func taskDone() {
        tasks -= 1
    }
}

class projectManager {
    var engineer: Engineer?

    func addTaskToEngineer() {
        engineer?.tasks += 1
    }
}

extension projectManager:EngineerDelegate {
    func tasksHasEnded() {
        print("Give me new tasks")
    }
}

var engener = Engineer()
var manager = projectManager()
engener.delegate = manager
manager.engineer = engener
manager.addTaskToEngineer()

engener.tasks
