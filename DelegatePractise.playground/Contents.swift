import UIKit

// 1. protocol
// 2. obj1: property weak var delegate: ProtocolDelegate?
// 3. obj2: :ProtocolDelegate

//AnyObject now we can make delegate as weak property
protocol EngineerTaskDelegate: AnyObject {
    func tasksHasEnded()
    func didFinishResearch(data: String)
    func didFinishAnalyzeRequirements(result: [String])
}

protocol EngineerConferenceDelegate: AnyObject {
    func didCreatePresentation()
}

class Engineer {
    weak var taskDelegate: EngineerTaskDelegate?
    weak var conferenceDelegate: EngineerConferenceDelegate?

    var tasks: Int = 0 {
        didSet {
            if tasks == 0 {
                taskDelegate?.tasksHasEnded()
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
        taskDelegate?.didFinishResearch(data: "document")
    }

    func analyze(requirements: [String]) {
        //read
        //questions
        //document
        taskDelegate?.didFinishAnalyzeRequirements(result: ["question 1", "question 2"])
    }
}

class ProjectManager {
    var engineer: Engineer?

    func addTaskToEngineer(_ numberOfTasks: Int = 1) {
        engineer?.tasks += numberOfTasks
    }
}

extension ProjectManager: EngineerTaskDelegate {
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

extension Client: EngineerTaskDelegate {
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
engineer.taskDelegate = manager
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

//disconnect. manager dismissed. engineer on bench
manager.engineer = nil
engineer.taskDelegate = nil

var client = Client()
client.engineer = engineer
engineer.taskDelegate = client

engineer.tasks
engineer.tasks += 1
engineer.tasks
engineer.taskDone()
engineer.tasks

print()


// 1. protocol
// 2. obj1: property weak var delegate: ProtocolDelegate?
// 3. obj2: :ProtocolDelegate
// 4. find out who the notification is coming from

//screen
class ViewController {
    var payView: [PayView]
    //To get action from PayView we need to subscribe on delegate
    //In view did load
    //Or
    //In init
    init(payView: [PayView]) {
        self.payView = payView
        payView.forEach { $0.delegate = self }
    }
}

extension ViewController: PayViewDelegate {
    func didPressPayButton(_ view: PayView) {
        print("show pay screen for \(view.price)")
    }
}

protocol PayViewDelegate: AnyObject {
    func didPressPayButton(_ view: PayView) // UIView
}

//little view (button or label or cell or search bar...)
class PayView {
    var price: Double = 0.0
    weak var delegate: PayViewDelegate?

    func action() {
        //add animation
        delegate?.didPressPayButton(self)
    }
}

var monitor = PayView()
monitor.price = 500
var headset = PayView()
headset.price = 300
var mouse = PayView()
mouse.price = 50

//to show on screen
var screen = ViewController(payView: [monitor, headset, mouse])

monitor.action()
mouse.action()
headset.action()
