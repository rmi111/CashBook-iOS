//
//  Constants.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/5/25.
//

import Foundation
import SwiftUICore

enum FirebasePaths: String {
    case transactions = "transactions"
    case users = "users"
    case categories = "categories"
    case goals = "goals"
    case budgets = "budgets"
}

enum UIStrings: String {
    case appName = "app_name"
    case activeTasks = "active_tasks"
    case irreversibleAction = "irreversible_action"
    case cancel = "cancel"
    case completedBy = "completed_by"
    case completedTasks = "completed_tasks"
    case create = "create"
    case delete = "delete"
    case deleteProjectError = "delete_project_error"
    case descriptionOptional = "description_optional"
    case genericErrorMessage = "generic_error_message"
    case noActiveProjects = "no_active_projects"
    case noCompletedTasks = "no_completed_tasks"
    case noResultsFound = "no_results_found"
    case projects = "projects"
    case projectName = "project_name"
    case remove = "remove"
    case removeUserError = "remove_user_error"
    case removeUserMessage = "remove_user_message"
    case rename = "rename"
    case searchByEmail = "search_by_email"
    case signingOut = "signing_out"
    case signOut = "sign_out"
    case skip = "skip"
    case userEmail = "user_email"
    case userName = "user_name"
}

extension UIStrings {
    var localizedKey: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    var string: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
