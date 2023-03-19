//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

class VolunteerDAO: DAO<Volunteer> {

    // Making the use of that method impossible because we can't create a volunteer like this, creating a volunteer
    // can only be done by a new user signing up on the app.
    @available(*, unavailable, message:"Can't create a volunteer with that method")
    override public func create(url: String, newObject: Volunteer) async throws {
        print("Not Supported")
    }

}
