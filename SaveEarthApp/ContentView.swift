//
//  ContentView.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-10-24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("score") var score: Int = 40
    
    private let goodActs: [String: (Int, String)] = [
        "Used Train \nInstead of Car":(3, "train_icon"),
        //"Used Bus Instead of Car":(3, "bus_icon"),
        "Took Your Own Bag":(3, "own_bag_icon"),
        "Used a Paper Straw":(3, "paper_straw_icon"),
        "Used a Water Bottle":(3, "water_bottle_icon"),
        "Bought an \nElectric Car":(15, "electric_car_icon"),
        "Joined a \nBeach Cleanup":(7, "beach_icon"),
        "Joined a \nStreet Cleanup":(7, "tongs_icon"),
        "Ate Vegetables":(3, "vegetable_icon"),
        "Shorter Shower":(2, "shower_icon"),
        "Lowered Heater":(2, "heater_icon"),
        "Lowered AC":(2, "AC_icon"),
        "Switched to \nLED Light":(5, "light_icon"),
        "Hanged Clothes \nOutside":(2, "clothes_icon"),
        "Grew a Vegetable":(5, "grow_vegetable_icon"),
        "Composted Your \nLeftovers":(6, "compost_icon")
    ]
    
    private let badActs: [String: (Int, String)] = [
        "Unnecessary Car":(3, "car_icon"),
        "Bought a \nPlastic Bag":(3, "plastic_bag_icon"),
        "Used a \nPlastic Straw":(3, "plastic_straw_icon"),
        "Bought a \nPlastic Bottle":(3, "plastic_bottles_icon"),
        "Too Long Shower":(2, "shower_long_icon"),
        "Too Much Heater":(2, "heater_icon"),
        "Too Much AC":(2, "AC_icon"),
        "Unnecessary Dryer":(2, "dryer_icon"),
        "Too Much \nLeftover Waste":(2, "leftover_icon")
    ]
    
    init() {
            //TabViewの背景色の設定（青色）
        UITabBar.appearance().backgroundColor = UIColor.black
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(.gray)
        
        }
        
    
    var body: some View {
            
            TabView {
                
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("\(score)")
                            .font(.system(size: 40))
                            .foregroundColor(Color.gray)
                            .padding()
                            .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 3)
                                )
                            .padding()
                        
                        Spacer()
                        
                        switch score {
                        case ...0:
                            //EarthView(phase: 0)
                            Image("explosion")
                                .resizable()
                                .scaledToFit()
                        case 1...5:
                            EarthView(phase: 1)
                        case 6...10:
                            EarthView(phase: 2)
                        case 11...15:
                            EarthView(phase: 3)
                        case 16...20:
                            EarthView(phase: 4)
                        case 21...25:
                            EarthView(phase: 5)
                        case 26...30:
                            EarthView(phase: 6)
                        case 31...35:
                            EarthView(phase: 7)
                        case 36...40:
                            EarthView(phase: 8)
                        case 41...45:
                            EarthView(phase: 9)
                        case 46...50:
                            EarthView(phase: 10)
                        case 51...55:
                            EarthView(phase: 11)
                        case 56...60:
                            EarthView(phase: 12)
                        case 61...65:
                            EarthView(phase: 13)
                        case 66...70:
                            EarthView(phase: 14)
                        case 71...75:
                            EarthView(phase: 15)
                        case 76...:
                            Image("earth_saved")
                                .resizable()
                                .scaledToFit()
                        default:
                            EarthView(phase: 8)
                        }
                        
                        ChoicesView(score: $score, goodActs: goodActs, badActs: badActs)
                        
                    }
                    .padding()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "figure.walk")
                        
                        Text("Act")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
                    .tabItem {
                        VStack {
                            Image(systemName: "cube.transparent")
                            Text("LeARn")
                        }
                    }
                
                ResorcesView()
                    .tabItem {
                        VStack {
                            Image(systemName: "books.vertical")
                            
                            Text("Library")
                        }
                        .padding(9)
                    }
                
                AboutView()
                    .tabItem {
                        VStack {
                            Image(systemName: "questionmark.circle")
                            Text("How to Play")
                        }
                        .padding()
                    }
               
            }
            .accentColor(Color("tabItemColor"))
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ChoicesView: View {
    @Binding var score: Int
    let goodActs: [String: (Int, String)]
    let badActs: [String: (Int, String)]
    
    var pageNumGood: Int {
           get {
               return Int(floor(Double(goodActs.count/3)))
           }
       }
    
    var pageNumBad: Int {
           get {
               return Int(floor(Double(badActs.count/3)))
           }
       }
    
    func getScores(dict: [String: (Int, String)]) -> [Int] {
        var scores: [Int] = []
        for (_, value) in dict {
            scores.append(value.0)
        }
        return scores
    }
    
    func getIcons(dict: [String: (Int, String)]) -> [String] {
        var icons: [String] = []
        for (_, value) in dict {
            icons.append(value.1)
        }
        return icons
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            TabView {
                ForEach(0..<pageNumGood, id: \.self) { page in
                    HStack {
                        ForEach(0..<3) { num in
                            Button(action: {
                                score += getScores(dict: goodActs)[3*page+num]
                            }, label: {
                                ZStack(alignment: .top) {
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 100, height: 80)
                                        .foregroundColor(Color("good_color"))
                                    
                                    Image(getIcons(dict: goodActs)[3*page+num])
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding(.top, 8)
                                    
                                    Text("\(Array(goodActs.keys)[3*page+num])")
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                        .font(.system(size: 10, design: .rounded))
                                        .bold()
                                        .offset(y: 50)
                                }
                            })
                        }
                            
                    }
                    .padding(.horizontal)
                    
                }
                
                if (goodActs.count-3*pageNumGood > 0) {
                    
                    HStack {
                        ForEach(0...(goodActs.count-3*pageNumGood-1), id: \.self) { num in
                            Button(action: {
                                score += getScores(dict: goodActs)[3*pageNumGood+num]
                            }, label: {
                                ZStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 100, height: 80)
                                        .foregroundColor(Color("good_color"))
                                    
                                    Image(getIcons(dict: goodActs)[3*pageNumGood+num])
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding(.top, 8)
                                    
                                    Text("\(Array(goodActs.keys)[3*pageNumGood+num])")
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                        .font(.system(size: 10, design: .rounded))
                                        .bold()
                                        .offset(y: 50)
                                }
                            })
                        }
                            
                    }
                    .padding(.horizontal)

                }
                
                
            }
            
            .tabViewStyle(.page(indexDisplayMode: .never))
            .tabViewStyle(.page)
            
            
            
            TabView {
                ForEach(0..<pageNumBad, id: \.self) { page in
                    HStack {
                        ForEach(0..<3) { num in
                            Button(action: {
                                score -= getScores(dict: badActs)[3*page+num]
                            }, label: {
                                ZStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 100, height: 80)
                                        .foregroundColor(Color("bad_color"))
                                    
                                    Image(getIcons(dict: badActs)[3*page+num])
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding(.top, 8)
                                    
                                    Text("\(Array(badActs.keys)[3*page+num])")
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                        .font(.system(size: 10, design: .rounded))
                                        .bold()
                                        .offset(y: 50)
                                }
                            })
                        }
                            
                    }
                    .padding(.horizontal)
                    
                }
                
                if (badActs.count-3*pageNumBad > 0) {
                    
                    HStack {
                        ForEach(0...(badActs.count-3*pageNumBad-1), id: \.self) { num in
                            Button(action: {
                                score -= getScores(dict: badActs)[3*pageNumBad+num]
                            }, label: {
                                ZStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 100, height: 80)
                                        .foregroundColor(Color("bad_color"))
                                    
                                    Image(getIcons(dict: badActs)[3*pageNumBad+num])
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding(.top, 8)
                                    
                                    Text("\(Array(badActs.keys)[3*pageNumBad+num])")
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                        .font(.system(size: 10, design: .rounded))
                                        .bold()
                                        .offset(y: 50)
                                }
                            })
                        }
                            
                    }
                    .padding(.horizontal)

                }
                
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .tabViewStyle(.page)
        
        }
        .padding()
    }
}

struct ResorcesView: View {
    var body: some View {
        NavigationView {
            
            List {
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.8, green: 0.7, blue: 0.1).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.8, green: 0.7, blue: 0.1).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Save energy at home").font(.title).padding()
                        Text("Much of our electricity and heat are powered by coal, oil and gas. Use less energy by lowering your heating and cooling, switching to LED light bulbs and energy-efficient electric appliances, washing your laundry with cold water, or hanging things to dry instead of using a dryer.").padding()
                    }
                }) {
                    Text("Save energy at home")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.1, green: 0.7, blue: 0.6).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.1, green: 0.7, blue: 0.6).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Walk, bike, or take public transport").font(.title).padding()
                        Text("The world’s roadways are clogged with vehicles, most of them burning diesel or gasoline. Walking or riding a bike instead of driving will reduce greenhouse gas emissions -- and help your health and fitness. For longer distances, consider taking a train or bus. And carpool whenever possible.").padding()
                    }
                }) {
                    Text("Walk, bike, or take public transport")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.1, green: 0.8, blue: 0.4).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.1, green: 0.8, blue: 0.4).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Eat more vegetables").font(.title).padding()
                        Text("Eating more vegetables, fruits, whole grains, legumes, nuts, and seeds, and less meat and dairy, can significantly lower your environmental impact. Producing plant-based foods generally results in fewer greenhouse gas emissions and requires less energy, land, and water.").padding()
                    }
                }) {
                    Text("Eat more vegetables")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.7, green: 0.5, blue: 0.3).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.7, green: 0.5, blue: 0.3).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Consider your travel").font(.title).padding()
                        Text("Airplanes burn large amounts of fossil fuels, producing significant greenhouse gas emissions. That makes taking fewer flights one of the fastest ways to reduce your environmental impact. When you can, meet virtually, take a train, or skip that long-distance trip altogether.").padding()
                    }
                }) {
                    Text("Consider your travel")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.4, green: 0.7, blue: 0.2).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.4, green: 0.7, blue: 0.2).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Throw away less food").font(.title).padding()
                        Text("When you throw food away, you're also wasting the resources and energy that were used to grow, produce, package, and transport it. And when food rots in a landfill, it produces methane, a powerful greenhouse gas. So use what you buy and compost any leftovers.").padding()
                    }
                }) {
                    Text("Throw away less food")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.2, green: 0.6, blue: 0.7).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.2, green: 0.6, blue: 0.7).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Reduce, reuse, repair & recycle").font(.title).padding()
                        Text("Electronics, clothes, and other items we buy cause carbon emissions at each point in production, from the extraction of raw materials to manufacturing and transporting goods to market. To protect our climate, buy fewer things, shop second-hand, repair what you can, and recycle.").padding()
                    }
                }) {
                    Text("Reduce, reuse, repair & recycle")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.7, green: 0.2, blue: 0.6).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.7, green: 0.2, blue: 0.6).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Change your home's source of energy").font(.title).padding()
                        Text("Ask your utility company if your home energy comes from oil, coal or gas. If possible, see if you can switch to renewable sources such as wind or solar. Or install solar panels on your roof to generate energy for your home.").padding()
                    }
                }) {
                    Text("Change your home's source of energy")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.7, green: 0.8, blue: 0.1).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.7, green: 0.8, blue: 0.1).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Switch to an electric vehicle").font(.title).padding()
                        Text("If you plan to buy a car, consider going electric, with more and cheaper models coming on the market. Even if they still run on electricity produced from fossil fuels, electric cars help reduce air pollution and cause significantly fewer greenhouse gas emissions than gas or diesel-powered vehicles.").padding()
                    }
                }) {
                    Text("Switch to an electric vehicle")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.8, green: 0.6, blue: 0.1).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.8, green: 0.6, blue: 0.1).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Make your money count").font(.title).padding()
                        Text("Everything we spend money on affects the planet. You have the power to choose which goods and services you support. To reduce your environmental impact, buy local and seasonal foods, and choose products from companies who use resources responsibly and are committed to cutting their gas emissions and waste.").padding()
                    }
                }) {
                    Text("Make your money count")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
                
                NavigationLink(destination: ZStack(alignment: .center) {
                    
                    Color(red:0.1, green: 0.6, blue: 0.8).opacity(0.3)
                        .ignoresSafeArea()
                    
                    Circle()
                        .foregroundColor(Color(red:0.1, green: 0.6, blue: 0.8).opacity(0.8))
                        .padding()
                    
                    VStack {
                        Text("Speak up").font(.title).padding()
                        Text("Speak up and get others to join in taking action. It's one of the quickest and most effective ways to make a difference. Talk to your neighbors, colleagues, friends, and family. Let business owners know you support bold changes. Appeal to local and world leaders to act now.").padding()
                    }
                }) {
                    Text("Speak up")
                }
                .frame(height: 50)
                .listRowBackground(Color("list_row_bg"))
            }
            .listStyle(.grouped)
            .navigationTitle("10 Actions You Can Take")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.primary)
    }
}

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("How to Play")
                    .font(.largeTitle)
                    .foregroundColor(Color("text_color"))
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Group {
                    Text("  For the last hundreds of years, we humans have been destroying this planet for the sake of industrial development. Now, the Earth can no longer stand our selfish behaviors. We must do something. And the individual everyday effort is a necessity.")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    
                    Text("  This SaveEarthApp! has three main features: 'Act' and 'AR.'")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                }
                
                Group {
                    Text("1. Act")
                        .font(.title2)
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom,5)
                    
                    Text("  This is like a game! Every time you do something good or bad for the environment, you tap a button on the 'Act' page. You get scores for doing good and lose ones for doing bad. As the scores change, the appearance of the 3D earth changes accordingly. So try not to make the planet explode (Boom!)")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                }
                
                Group {
                    Text("2. LeARn")
                        .font(.title2)
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("  This is where you can le'AR'n what you can do! Go ahead and use your camera to look around and tap on the surface of a horizontal plane (floor, table, etc.) A random 3D object and a board with a brief explanation will show up in the Augmented Reality (AR) space.")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    Text("  --__Tips__-- \n①Move your camera slowly around the plane from different angles for 5-10 seconds to successfully detect the plane. The closer the better! \n②Tap anywhere on the plane to create as many objects and explanations as you want. \n③Use the 'Reset' button to delete all the existing objects and explanations.")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                    
                    HStack {
                        Image("demo computer")
                            .resizable()
                            .scaledToFit()
                        Image("demo plasticBottle & book")
                            .resizable()
                            .scaledToFit()
                    }
                    .padding()
                }
                
                Group {
                    Text("Save the Earth!")
                        .font(.title2)
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("  Even seemingly small things have a lot to do with if each of us does the same. Take some time to look into the 'Library' and try to find something you can do on daily basis. If you find some, do it! And tap the buttons to make the earth look better! Let's save Mother Earth together!")
                        .foregroundColor(Color("text_color"))
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                }
            }
        }
    }
}

struct ARViewContainer: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ARContainerViewController
    
    func makeUIViewController(context: Context) -> ARContainerViewController {
        return ARContainerViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARContainerViewController, context: Context) {
        
    }
}
