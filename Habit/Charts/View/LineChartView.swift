//
//  BoxChartView.swift
//  Habit
//
//  Created by Adriano on 07/12/23.
//

import SwiftUI
import Charts

struct LineChartView: View {
    
    @Binding var entries: [DataForCharts]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                ForEach(entries) { dados in
                    LineMark(
                        x: .value("Dia", dados.day),
                        y: .value("Valor", dados.value))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
        else {
            // Fallback on earlier versions
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(entries: .constant([
            DataForCharts(day: "01/01", value: 3),
            DataForCharts(day: "02/01", value: 5),
            DataForCharts(day: "03/01", value: 2),
            DataForCharts(day: "04/01", value: 8),
            DataForCharts(day: "05/01", value: 0),
            DataForCharts(day: "06/01", value: 1),
            DataForCharts(day: "07/01", value: 2),
            DataForCharts(day: "08/01", value: 7),
            DataForCharts(day: "09/01", value: 9),
            DataForCharts(day: "10/01", value: 6),
        ]))
    }
}
