//
//  ViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - Properties

    private var subscriptions: [Subscription] = []

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        LocalSubscriptionRepository.items { subscriptions in
            self.subscriptions = subscriptions ?? []
        }
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Configurations

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - TODO
    // 세그먼트를 선택하면 각각의 세그먼트에 관한 데이터를 불러옴
    // 만료됨 세그먼트를 선택하면 cell에 회색의 블라인드 처리

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListSubscriptionCell.reuseIdentifier, for: indexPath) as! ListSubscriptionCell

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.endCellView.backgroundColor = .clear
            cell.subscriptionNameLabel.text = "네이버"
        case 1:
            cell.endCellView.backgroundColor = .systemGray6
            cell.endCellView.alpha = 0.5
            cell.subscriptionNameLabel.text = "디즈니"
        default:
            break
        }

        return cell
        // 데이터 불러오기
        //        guard let item = writeSubInfo?[indexPath.row] as? [String: Any] else { return cell }
        //
        //        cell.subscriptionNameLabel.text = item["planName"] as? String
        //        guard let thumImage = item["img"] as? String else { return cell }
        //
        //        // TODO: image 수정
        //        cell.subscriptionImageView.image = UIImage(named: "logo.png")
        //        cell.stratDateLabel.text = item["subStartDay"] as? String
        //
        //        guard let price = item["planPrice"] as? String else { return cell }
        //        guard let cycle = item["cycle"] as? String else { return cell }
        //        let numberFormatter = NumberFormatter()
        //        numberFormatter.numberStyle = .decimal
        //        cell.priceLabel.text = "\(numberFormatter.string(for: Int(price))!)원/\(cycle)"
        //
        //        // D-day OK
        //       if let dateString = item["subStartDay"] as? String {
        //            let formatter = DateFormatter()
        //            formatter.dateFormat = "yyyy.MM.dd"
        //            if let date = formatter.date(from: dateString) {
        //                let now = Date()
        //                let dDay = Calendar.current.dateComponents([.day], from: date, to: now).day! + 1
        //                cell.dDayLabel.text = "D + \(dDay)"
        //            }
        //        }
        //        return cell
    }

}
