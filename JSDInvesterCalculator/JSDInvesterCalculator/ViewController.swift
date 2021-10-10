//
//  ViewController.swift
//  JSDInvesterCalculator
//
//  Created by Jersey on 10/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let monthMoney: Double = 12600
    let sumMonth: Double = 25 * 12
    let monthInterest: Double = 0.0033333333
    let yearInterest: Double = 0.04
    let yyearInterest: Double = 0.06
    var sumMoney: Double = 0
    var sumInvest: Double = monthMoney * 15
    // 18 年后年金+收益
//        let sumInvest: Double = 189000 378000
//        let sumMoney: Double = 259247
    //定年投结息 12600, 本金 189000 收益: 73389, 总: 262389, 年化 0.04
    //月定投结息 1050, 本金 189000 收益: 70256, 总: 259256, 年化 0.04
    //年定投第 20 年翻倍(189000), 390211, 收益 138211 总投资 252000
    //月定投第 19 年 11 月翻倍(189000), 379419, 收益 130569, 总投资 248850
    //年定投第 25 年, 总收益 545727, 收益 230727 总投资 315000
    //年定投第 15 年, 计息至 25 年: 总收益 388389, 收益 199389 总投资 189000
    //5年定投结息 63000, 本金 189000, 收益: 23600, 总: 212600 15
    //5年定投结息 63000, 本金 189000, 收益: 40136, 总: 292136 20
    for i in 1...25 {
        sumMoney += monthMoney
        let moenyInterest = sumMoney * yearInterest
        if i <= 15 {
            sumMoney += moenyInterest
        }
        NSLog("当前投资第\(Int(i/12))年-第:\(i)月, 当月收益: \(moenyInterest), 累积总金额:\(sumMoney)")
//            if sumMoney >= 450000 {
//                NSLog("触发指标: 当前投资第\(Int(i/12))年-第:\(i)年, 当月收益: \(moenyInterest), 累积总金额:\(sumMoney)")
//                break
//            }
    }
    NSLog("15 年过去后, 本金累加收益:\(sumMoney), 总投资本金: \(sumInvest), 收益: \(sumMoney - sumInvest)")
}

