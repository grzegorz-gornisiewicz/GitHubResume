//
//  ResumeTableViewController.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 12/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import UIKit
import Foundation

class ResumeTableViewController: UITableViewController {
    private var acntname: String?
    private var pages: Int = 0
    private var page: Int = 0
    private var reposWithLang: Int = 0
    private var error: Error?
    private var user: User?
    private var repos: [Repo]?
    private var langs: [String:Int] = [:]

    private enum Sections: CaseIterable {
        case name
        case summary
        case website
        case langs
        case repos
        
        var rawValue: (section: Int, title: String) {
            get {
                switch self {
                case .summary:
                    return (1,  "Profile summary")
                case .website:
                    return (2,  "Website")
                case .langs:
                    return (3,  "Languages")
                case .repos:
                    return (4,  "Repositories")
                default:
                    return (0, "")
                }
            }
        }
    }

    private let userReq = SingleUserRequest()
    private let reposReq = ReposRequest()

    private func initilizeData() {
        
    }
    
    @objc private func refreshData(_ sender: Any) {
        acntname = UserDefaults.standard.string(forKey: "AccountName")
        if let accountname = acntname {
            reposWithLang = 0
            user = nil
            repos = []
            langs = [:]
            pages = 0
            page = 0
            userReq.get(accountname) { (user, error) in
                if error == nil {
                    self.user = user
                    self.pages = (user?.public_repos)! / 30
                    self.getReposData(accountname)
                } else {
                    self.error = error
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func getReposData(_ accountname: String) {
        reposReq.get(accountname, page) { (repos, error) in
            self.error = error

            if self.repos == nil {
                self.repos = repos
            } else {
                self.repos?.append(contentsOf: repos!)
            }

            self.page += 1

            if self.page <= self.pages {
                self.getReposData(accountname)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                if let urepos = repos {
                    for repo in urepos {
                        if let l = repo.language {
                            print("lang:" + l)
                            var count = self.langs[l] ?? 0
                            count += 1
                            self.langs[l] = count
                            self.reposWithLang += 1
                        }
                    }
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        self.tableView.beginUpdates()
                        self.tableView.reloadSections([0], with: .automatic)
                        for section in 1...(Sections.allCases.count - 1) {
                            self.tableView.insertSections([section], with: .automatic)
                        }
                        self.tableView.endUpdates()
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .green // UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.beginRefreshing()

        initilizeData()
        
        refreshData(refreshControl!)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .orange
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.langs.rawValue.section:
            return Sections.allCases[section].rawValue.title + " (\(langs.count))"
        case Sections.repos.rawValue.section:
            return Sections.allCases[section].rawValue.title + " (\(repos?.count ?? 0))"
        default:
            return  Sections.allCases[section].rawValue.title
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if refreshControl!.isRefreshing  {
            return 1
        }
        
        return Sections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.langs.rawValue.section:
            return langs.count
        case Sections.repos.rawValue.section:
            return repos?.count ?? 0
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if user != nil {
            switch indexPath.section {
            case Sections.name.rawValue.section:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderViewCell", for: indexPath) as! ProfileHeaderViewCell
                cell.user = user
                return cell
            case Sections.summary.rawValue.section:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSummaryViewCell", for: indexPath) as! ProfileSummaryViewCell
                cell.user = user
                return cell
            case Sections.website.rawValue.section:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultViewCell", for: indexPath)
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.text = user?.blog ?? "-"
                cell.accessoryType = .disclosureIndicator
                return cell
            case Sections.langs.rawValue.section:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultViewCell", for: indexPath)
                cell.textLabel?.textAlignment = .left
                let sorted = self.langs.sorted { $0.value > $1.value }
                let pct = Int(100.0 * Double(sorted[indexPath.row].value) / Double(self.reposWithLang))
                cell.textLabel?.text = sorted[indexPath.row].key + " (\(pct)%)"
                cell.accessoryType = .disclosureIndicator
                return cell
            case Sections.repos.rawValue.section:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RepoSummaryViewCell", for: indexPath) as! RepoSummaryViewCell
                cell.repo = repos?[indexPath.row]
                cell.accessoryType = .disclosureIndicator
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultViewCell", for: indexPath)
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.text = ""
                cell.accessoryType = .none
                return cell
            }
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultViewCell", for: indexPath)
        cell.accessoryType = .none
        
        if refreshControl!.isRefreshing {
            cell.textLabel?.text = "Loading account details."
            cell.textLabel?.textAlignment = .center
        } else {
            if let msg = acntname {
                cell.textLabel?.text = "User '" + msg + "' not found on Github"
                cell.textLabel?.textAlignment = .left
            } else {
                cell.textLabel?.text = "Unknow error"
                cell.textLabel?.textAlignment = .left
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case Sections.website.rawValue.section:
            if let blog =  user?.blog {
                guard let url = URL(string: blog) else { return }
                UIApplication.shared.open(url)
            }
        case Sections.langs.rawValue.section:
            let sorted = langs.sorted { $0.value > $1.value }
            let string = "https://github.com/search?q=user:\(acntname ?? "")&l=\(sorted[indexPath.row].key)"
            guard let url =  URL(string: string) else { return }
            UIApplication.shared.open(url)
        case Sections.repos.rawValue.section:
            let repo = repos?[indexPath.row]
            guard let url =  URL(string: repo?.html_url ?? "") else { return }
            UIApplication.shared.open(url)
        default:
            print()
        }
    }
}
