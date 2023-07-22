//
//  DoTryCatchBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by M Tayyab on 22/07/2023.
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThrowsBootcampManager {
    
    var isActive: Bool = false
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT!", nil)
        }
        else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String,Error>  {
        if isActive {
            return .success("NEW TEXT!")
        }
        else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "NEW TEXT!"
        }
        else {
            throw URLError(.badServerResponse)
        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT!"
        }
        else {
            throw URLError(.badServerResponse)
        }
    }
    
}
class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    @Published var text: String = "Starting text"
    let manager = DoCatchTryThrowsBootcampManager()
    
    func fetchTitle (){
        /*let returnValue = manager.getTitle()
        if let newTitle = returnValue.title {
            self.text = newTitle
        }
        else if let error = returnValue.error {
            self.text = error.localizedDescription
        }*/
        /*let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }*/
        
        
        
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
            
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
            
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct DoTryCatchBootcamp: View {
    
    @StateObject var viewModel = DoCatchTryThrowsBootcampViewModel()
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoTryCatchBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoTryCatchBootcamp()
    }
}
