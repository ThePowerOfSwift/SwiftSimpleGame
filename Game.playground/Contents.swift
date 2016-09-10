
struct Point {
    
    let x: Int
    let y: Int
    
    func surroundingPoints(withRange range: Int = 1) -> [Point] {
        var results = [Point]()
        for coordX in (x - range)...(x + range) {
            for coordY in (y - range)...(y + range) {
                let coordinatePoint = Point(x: coordX, y: coordY)
                results.append(coordinatePoint)
            }
        }
        return results
    }
}

class Enemy {
    var life = 2
    let position: Point
    
    init(x: Int, y: Int) {
        position = Point(x: x, y: y)
    }
    
    func decreaseHealth(factor: Int) {
        life -= factor
    }
}


class Tower {
    let position: Point
    var range = 1
    var strenght = 1
    
    init(x: Int, y: Int) {
        position = Point(x: x, y: y)
    }
    
    
    func fireAtEnemy(enemy: Enemy) {
        if inRange(position: self.position, andRange: self.range, toTarget: enemy.position) {
            while enemy.life > 0 {
                enemy.decreaseHealth(factor: self.strenght)
                print("Enemy vanquished!")
            }
        } else {
          print("Enemy is out of range!")
        }
    }
    
    func inRange(position: Point, andRange range: Int, toTarget target: Point) -> Bool {
        let aviablePositions = position.surroundingPoints(withRange: range)
        for point in aviablePositions {
            if (point.x == target.x) && (point.y == target.y) {
                return true
            }
        }
        return false
    }
}


class SuperEnemy: Enemy {
    let isSuper = true
    
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
        self.life = 50
    }
}


class LaserTower: Tower {
    
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
        
        self.range = 100
        self.strenght = 100
    }
    
    override func fireAtEnemy(enemy: Enemy) {
        while enemy.life >= 0 {
            enemy.decreaseHealth(factor: strenght)
        }
        print("Enemy vanquished!")
    }
}

let tower = Tower(x: 0, y: 0)
let enemy = Enemy(x: 1, y: 1)
tower.fireAtEnemy(enemy: enemy)





