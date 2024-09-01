//
//  IamportVC.swift
//  BookChallenge
//
//  Created by 박성민 on 9/1/24.
//

import UIKit
import iamport_ios
import WebKit

final class IamportVC: BaseViewController {
    var buyModel: BuyBookModel = BuyBookModel(bookTitle: "", price: "", postId: "'")
    private lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    private lazy var payment = IamportPayment(
        pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
        merchant_uid: "ios_\(LSLP.key)_\(Int(Date().timeIntervalSince1970))",
        amount: buyModel.price).then {
            $0.pay_method = PayMethod.card.rawValue
            $0.name = buyModel.bookTitle
            $0.buyer_name = UserManager.shared.userId
            $0.app_scheme = "sesac"
        }
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "<\(buyModel.bookTitle)> 결제"
        super.viewDidLoad()
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        Iamport.shared.paymentWebView(
            webViewMode: wkWebView,
            userCode: LSLP.userCode,
            payment: payment) { [weak self] iamportResponse in
                guard let iamportResponse, let self else {return }
                if iamportResponse.success == true {
                    print(iamportResponse.imp_uid!)
                    print(buyModel.postId)
                    print("--------------------")
                    LSLPNetworkManager.shared.requestBuy(impId: iamportResponse.imp_uid!, postId: buyModel.postId) { response in
                        switch response {
                        case .success(let success):
                            self.simpleAlert(title: "\(self.buyModel.bookTitle) 구매 완료") {
                                self.popViewController()
                            }
                        case .failure(_):
                            self.simpleAlert(title: "결제 오류 발생 LSLP") {
                                self.popViewController()
                            }
                        }
                    }
                } else {
                    simpleAlert(title: "결제 오류 발생") {
                        self.popViewController()
                    }
                }
                
            }
    }
    
    
}
