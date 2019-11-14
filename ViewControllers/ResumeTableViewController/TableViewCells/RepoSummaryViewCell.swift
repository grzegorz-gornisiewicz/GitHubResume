//
//  RepoSummaryViewCell.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 13/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit

class RepoSummaryViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    private var _repo: Repo?
    public var repo: Repo? {
        set {
            _repo = newValue
            titleLabel?.text = _repo?.name

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let created = dateFormatter.date(from:_repo?.created_at ?? "")!
            let createdComponents = Calendar.current.dateComponents([.year], from: created)
            let updated = dateFormatter.date(from:_repo?.updated_at ?? "")!
            let updatedComponents = Calendar.current.dateComponents([.year], from: updated)

            if createdComponents.year != updatedComponents.year {
                yearLabel?.text = "\(createdComponents.year ?? 0)-\(updatedComponents.year ?? 0)"
            } else {
                yearLabel?.text = "\(createdComponents.year ?? 0)"
            }

            descriptionLabel?.text = _repo?.description

            summaryLabel?.text = "This repository has \(_repo?.stargazers_count ?? 0) stars and \(_repo?.forks ?? 0) forks."
        }
        get {
            return _repo
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
