import UIKit

var greeting = "Hello, playground"

//AnyObject now we can make delegate as weak property
protocol EngineerDelegate: AnyObject {
    func tasksHasEnded()
    func didFinishResearch(data: String)
    func didFinishAnalyzeRequirements(result: [String])
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

    func taskDone(_ taskDone: Int = 1) {
        tasks -= taskDone
    }

    func startResearch(_ data: String =  "") {
        //google
        //create doment
        //review doc
        delegate?.didFinishResearch(data: "document")
    }

    func analyze(requirements: [String]) {
        //read
        //questions
        //document
        delegate?.didFinishAnalyzeRequirements(result: ["question 1", "question 2"])
    }
}

class ProjectManager {
    var engineer: Engineer?

    func addTaskToEngineer(_ numberOfTasks: Int = 1) {
        engineer?.tasks += numberOfTasks
    }
}

extension ProjectManager: EngineerDelegate {
    func tasksHasEnded() {
        print("Client: Give me new tasks")
    }

    func didFinishResearch(data: String) {
        addTaskToEngineer(2)
    }

    func didFinishAnalyzeRequirements(result: [String]) {
        print("Client: Clarify requirements")
    }
}

class Client  {
    var engineer: Engineer?
}

extension Client: EngineerDelegate {
    func tasksHasEnded() {
        //think about requirements
        // think about tasks
        print("Add tasks to engineer")
        engineer?.tasks += 1
    }

    func didFinishResearch(data: String) {
        engineer?.tasks += 2
    }

    func didFinishAnalyzeRequirements(result: [String]) {
        print("Answers")
    }


}

var engineer = Engineer()
var manager = ProjectManager()
engineer.delegate = manager
manager.engineer = engineer
manager.addTaskToEngineer()

engineer.tasks
engineer.taskDone()

engineer.analyze(requirements: [])

engineer.tasks
engineer.startResearch()
engineer.tasks

engineer.taskDone(2)

engineer.tasks
// 1. protocol
// 2. obj1: property weak var delegate: ProtocolDelegate?
// 3. obj2: :ProtocolDelegate

//disconnect. manager dismissed. engineer on bench
manager.engineer = nil
engineer.delegate = nil

var client = Client()
client.engineer = engineer
engineer.delegate = client

engineer.tasks
engineer.tasks += 1
engineer.tasks
engineer.taskDone()
engineer.tasks
