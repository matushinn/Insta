//
//  TimelineTableViewCell.swift
//  InstaApp
//
//  Created by 大江祥太郎 on 2019/04/12.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit

protocol TimelineTableViewCellDelegate {
    func didTapLikeButton(tableViewCell:UITableViewCell,button:UIButton)
    func didTapMenuButton(tableViewCell:UITableViewCell,button:UIButton)
    func didTapCommentsButton(tableViewCell:UITableViewCell,button:UIButton)
}
class TimelineTableViewCell: UITableViewCell {
    
    var delegate:TimelineTableViewCellDelegate?
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var timestampLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //丸くする
        userImageView.layer.cornerRadius = userImageView.bounds.width/2.0
        userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func like(_ sender: Any) {
        self.delegate?.didTapLikeButton(tableViewCell: self, button: UIButton)
    }
    @IBAction func openMenu(_ sender: Any) {
        self.delegate?.didTapMenuButton(tableViewCell: self, button: UIButton)
    }
    @IBAction func showComments(_ sender: Any) {
        self.delegate?.didTapCommentsButton(tableViewCell: self, button: button)
    }
    
}
