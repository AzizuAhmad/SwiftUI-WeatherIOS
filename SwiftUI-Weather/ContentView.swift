//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by MacBook Air on 04/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack{
                CityTextView(cityName: "Semarang, ID")
                
                MainWeatherStatus(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                  temp: 76)
                
                WeatherDay(isNight: $isNight)
                Spacer()
                
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
                
                Spacer()
            }
        }

    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var day: String
    var image: String
    var temp: Int
    
    var body: some View {
        VStack{
            Text(day)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: image)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temp)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
            
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue,
            isNight ? .gray : Color(.lightblue)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium,design: .default))
            .foregroundStyle(.white)
            .padding()

    }
}
struct MainWeatherStatus: View {
    
    var imageName: String
    var temp: Int
    
    var body: some View {
        VStack(spacing: 8){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temp)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
    }
}

struct WeatherDay: View {
    
    @Binding var isNight: Bool

    var dayList = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    var imageDay = ["cloud.sun.fill","cloud.drizzle.fill","cloud.hail.fill",
                  "cloud.snow.fill","cloud.bolt.fill","cloud.bolt.rain.fill",
                  "cloud.sun.rain.fill"]
    var imageNight = ["moon.stars.fill","cloud.drizzle.fill","cloud.hail.fill",
                    "cloud.snow.fill","cloud.bolt.fill","cloud.bolt.rain.fill",
                    "cloud.sun.rain.fill"]
            
    var temp = [76,80,100,110,85]
    
    var body: some View {
        HStack(spacing: 20){
            ForEach(0..<5, id: \.self ){ i in
                WeatherDayView(day: dayList[i],
                               image: isNight ? imageNight[i] : imageDay[i],
                               temp: temp[i])
                
            }

        }
    }
}

