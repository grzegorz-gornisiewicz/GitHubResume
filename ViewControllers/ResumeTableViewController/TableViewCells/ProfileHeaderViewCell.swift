//
//  ProfileHeaderViewCell.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 13/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit

class ProfileHeaderViewCell: UITableViewCell {
    private var _user: User?
    public var user: User? {
        set {
            _user = newValue
            if let name = _user?.name {
                textLabel?.text = name + " (\(_user?.login ?? "-"))"
            } else {
                textLabel?.text = _user?.login ?? "-"
            }
            detailTextLabel?.text = _user?.bio ?? "Passionate github user"
        }
        get {
            return _user
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
