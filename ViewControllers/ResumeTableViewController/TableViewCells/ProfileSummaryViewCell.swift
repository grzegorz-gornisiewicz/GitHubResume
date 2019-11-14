//
//  ProfileSummaryViewCell.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 12/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit

class ProfileSummaryViewCell: UITableViewCell {
    private var _user: User?
    public var user: User? {
        set {
            _user = newValue
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:_user?.created_at ?? "")!
            let dateComponents = Calendar.current.dateComponents([.year], from: date)
            var txt = "On GitHub since \(dateComponents.year ?? 0), \(_user?.name ?? "John Doe") is a developer based in \(_user?.location ?? "Unknown"), with \(_user?.public_repos ?? 0) public repositories and \(_user?.followers ?? 0) followers."
            if _user?.followers == 1 {
                txt = txt.replacingOccurrences(of: "followers.", with: "follower.")
            }
            textLabel?.text = txt
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
