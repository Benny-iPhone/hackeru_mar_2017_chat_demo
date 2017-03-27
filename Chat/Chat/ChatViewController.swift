//
//  ChatViewController.swift
//  Chat
//
//  Created by hackeru on 27/03/2017.
//  Copyright © 2017 hackeru. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {

    var messages : [JSQMessage] = []
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderDisplayName = "user"
        self.senderId = "123"
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = .zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        testRecevingMessages()
    }
    
    //MARK: - My Methods
    
    func testRecevingMessages(){
        func addMessage(withId id: String, name: String, text: String) {
            if let message = JSQMessage(senderId: id, displayName: name, text: text) {
                messages.append(message)
            }
        }
        // messages from someone else
        addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
        // messages sent from local sender
        addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
        addMessage(withId: senderId, name: "Me", text: "I like to run!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
    
    
    
    
    func addTextMessage(with text : String){
        guard let msg = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: text) else{
            return
        }
        
        messages.append(msg)
        
        self.finishReceivingMessage()
        
    }
    
    //MARK: - Support JSQ
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        addTextMessage(with: text)
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let msg = messages[indexPath.item]
        if msg.senderId == self.senderId{
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let msg = messages[indexPath.item]
        let isOutgoing = msg.senderId == self.senderId
        cell.textView.textColor = isOutgoing ? .white : .black
        
        return cell
        
    }
}
















