import SwiftUI
import Charts

struct ContentView: View {
    @State private var topLinks: [Link] = []
    @State private var recentLinks: [Link] = []
    @State private var chartData: [ChartData] = []

    var body: some View {
        VStack {
            // Title and settings icon
            HStack {
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .padding()
            .padding(.top, 0) // Adjust this padding for space at the top

            Spacer()

            // White rectangle box
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(greetingMessage())
                            .font(.title3)
                            .padding(.bottom, 0)
                        HStack {
                            Text("Muskan Agrawal")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("👋")
                                .font(.title)
                        }
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.96, green: 0.95, blue: 0.95))
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .shadow(radius: 10)
            .padding(.top, 20) // Adjust this padding for space between title and box

            // Green box for WhatsApp
            VStack {
                HStack {
                    Image("whatsapp") // Custom image for WhatsApp
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("WhatsApp")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.9, green: 1, blue:0.9))
            .cornerRadius(20)
            .padding(.horizontal, 20) // Adjust the horizontal padding to fit the screen
            .padding(.bottom, 10) // Add space below the WhatsApp box

            // Green box for FAQs
            VStack {
                HStack {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.blue)
                    Text("Frequently asked questions")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.80, green: 0.90, blue: 1))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 20) // Add space below the FAQs box

            // Footer
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "link")
                        Text("Links")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "book")
                        Text("Courses")
                    }
                    Spacer()
                    Spacer() // Add Spacer
                    VStack {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 45, height: 45)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                            .shadow(radius: 8) // Add shadow
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "megaphone")
                        Text("Campaigns")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    Spacer()
                }
                .padding(.vertical, 10) // Adjust vertical padding here
                .padding(.horizontal, 20) // Adjust horizontal padding here
                .foregroundColor(.black)
            }
            .background(Color.white)
        }
        .background(Color.blue.edgesIgnoringSafeArea(.all)) // Full screen blue background
        .onAppear(perform: loadData)
    }

    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<21:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }

    func loadData() {
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8t_bjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.topLinks = response.topLinks
                    self.recentLinks = response.recentLinks
                    self.chartData = response.chartData
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extend View to allow rounded corners on specific edges
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
