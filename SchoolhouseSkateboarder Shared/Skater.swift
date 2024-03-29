//
//  Skater.swift
//  SchoolhouseSkateboarder iOS
//
//  Created by Евгений Цуриков on 14.01.2022.
//

import SpriteKit

class Skater: SKSpriteNode {

    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 20.0
    var isOnGround = true
    
    
    func setupPhysicsBody() {
        if let skaterTexture = texture {
            physicsBody = SKPhysicsBody (texture: skaterTexture, size: size)
            physicsBody?.isDynamic = true
            physicsBody?.density = 6.0
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0
            physicsBody?.categoryBitMask = PhysicsCategory.skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick |
            PhysicsCategory.gem
        }
    }
    
    func createSparks () {
    
    // Находим файл эмиттера искр в проекте
    let bundle = Bundle.main
    if let sparksPath = bundle.path(forResource: "sparks", ofType: "sks") {
    
    // Создаем узел эмиттера искр
    
        let sparksNode = NSKeyedUnarchiver.unarchiveObject(withFile: sparksPath) as! SKEmitterNode
        sparksNode.position = CGPoint (x: 0.0, y: -50.0)
        addChild(sparksNode)
    
        // Производим действие, ждем полсекунды, а затем удаляем 8 эмиттер
        let waitAction = SKAction.wait(forDuration: 0.5)
        let removeAction = SKAction.removeFromParent()
        let waitThenRemove = SKAction.sequence([waitAction, removeAction])
        sparksNode.run (waitThenRemove)
     }
  }

}
