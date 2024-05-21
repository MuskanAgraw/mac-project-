import SwiftUI
import Charts

struct ChartView: View {
    var data: [ChartData]

    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("ID", item.id),
                y: .value("Value", item.value)
            )
        }
    }
}
