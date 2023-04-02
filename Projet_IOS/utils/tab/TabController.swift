//
// Created by Lorenzo Italiano on 29/03/2023.
//

import Foundation

class TabController: ObservableObject {
    @Published var activeTab = Tab.home

    func open(_ tab: Tab) {
        activeTab = tab
    }
}