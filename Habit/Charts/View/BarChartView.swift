//
//  BarChartView.swift
//  Habit
//
//  Created by Adriano on 20/12/23.
//

import SwiftUI
import Charts

struct BarChartView: View {
    @Binding var entries: [DataForCharts]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart(entries) { entry in
                BarMark(
                    x: .value("Dia", entry.day),
                    y: .value("Valor", entry.value))
                .foregroundStyle(Color.green.gradient)
                
            }
        }
        else {
            // Fallback on earlier versions
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(entries: .constant([
            DataForCharts(day: "01/01", value: 3),
            DataForCharts(day: "02/01", value: 5),
            DataForCharts(day: "03/01", value: 2),
            DataForCharts(day: "04/01", value: 8),
            DataForCharts(day: "05/01", value: 5),
            DataForCharts(day: "06/01", value: 1),
            DataForCharts(day: "07/01", value: 2),
            DataForCharts(day: "08/01", value: 7),
            DataForCharts(day: "09/01", value: 9),
            DataForCharts(day: "10/01", value: 6),
            DataForCharts(day: "11/01", value: 15),
            DataForCharts(day: "12/01", value: 2),
            DataForCharts(day: "13/01", value: 12),
            DataForCharts(day: "14/01", value: 1),
            DataForCharts(day: "15/01", value: 9),
        ]))
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}
