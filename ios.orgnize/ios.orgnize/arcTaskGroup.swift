import SwiftUI
import Combine



class ArcTaskGroup: ObservableObject, Codable, Equatable {
    static func == (lhs: ArcTaskGroup, rhs: ArcTaskGroup) -> Bool {
        if(lhs.id == rhs.id){
            return true
        }else{
            return false
        }
    }

    
    var id: UInt32
    var heading: String
    

    @Published var tasks: [String]
    
    var position1: CGPoint
    var position2: CGPoint
    
    var startDegree: Double
    var endDegree: Double
    
    var startTime: Time?
    var endTime: Time?
    
    enum CodingKeys: CodingKey {
        case id, heading, tasks, position1, position2, startDegree, endDegree, startTime, endTime
    }
    
    init(heading: String, id: UInt32) {
        self.id = id
        self.heading = heading
        
        self.position1 = CGPoint(x: 100, y: 0)
        self.position2 = CGPoint(x: 100, y: 0)
        
        self.startDegree = 0.0
        self.endDegree = 0.0
        
        self.startTime = Time(hours: 0, minutes: 0)
        self.endTime = Time(hours: 0, minutes: 0)
        
        self.tasks = []
    }
    
    func isTimeInRange(time: Time) -> Bool {
        guard let startTime = startTime, let endTime = endTime else { return false }
        if startTime.hours < endTime.hours || (startTime.hours == endTime.hours && startTime.minutes <= endTime.minutes) {
            return (time.hours > startTime.hours || (time.hours == startTime.hours && time.minutes >= startTime.minutes)) &&
                   (time.hours < endTime.hours || (time.hours == endTime.hours && time.minutes <= endTime.minutes))
        } else { // Range wraps around midnight
            return (time.hours > startTime.hours || (time.hours == startTime.hours && time.minutes >= startTime.minutes)) ||
                   (time.hours < endTime.hours || (time.hours == endTime.hours && time.minutes <= endTime.minutes))
        }
    }
          
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UInt32.self, forKey: .id)
        heading = try container.decode(String.self, forKey: .heading)
        tasks = try container.decode([String].self, forKey: .tasks)
        
        let position1Array = try container.decode([CGFloat].self, forKey: .position1)
        position1 = CGPoint(x: position1Array[0], y: position1Array[1])
        
        let position2Array = try container.decode([CGFloat].self, forKey: .position2)
        position2 = CGPoint(x: position2Array[0], y: position2Array[1])
        
        startDegree = try container.decode(Double.self, forKey: .startDegree)
        endDegree = try container.decode(Double.self, forKey: .endDegree)
        
        startTime = try container.decodeIfPresent(Time.self, forKey: .startTime)
        endTime = try container.decodeIfPresent(Time.self, forKey: .endTime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(heading, forKey: .heading)
        try container.encode(tasks, forKey: .tasks)
        
        try container.encode([position1.x, position1.y], forKey: .position1)
        try container.encode([position2.x, position2.y], forKey: .position2)
        
        try container.encode(startDegree, forKey: .startDegree)
        try container.encode(endDegree, forKey: .endDegree)
        
        try container.encodeIfPresent(startTime, forKey: .startTime)
        try container.encodeIfPresent(endTime, forKey: .endTime)
    }
    
    // ...
}
