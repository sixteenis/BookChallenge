//
//  FetchImageProtocol.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import UIKit
import Kingfisher

protocol FetchImageProtocol: AnyObject {
    func fetchImage(imageView: UIImageView, imageURL: String)
    func fetchLSLPImage(imageView: UIImageView, imageURL: String)
    func fetchPrfileImage(imageView: UIImageView, imageURL: String?)
}

extension FetchImageProtocol {
    func fetchImage(imageView: UIImageView, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.kf.setImage(
        with: url,
        placeholder: nil,
        options: [.transition(.fade(1.2))]
        )
    }
    func fetchLSLPImage(imageView: UIImageView, imageURL: String) {
        let modifier = AnyModifier { request in
            var req = request
            req.addValue(UserManager.shared.token, forHTTPHeaderField: BaseHeader.authorization.rawValue)
            req.addValue(LSLP.key, forHTTPHeaderField: BaseHeader.sesacKey.rawValue)
            return req
        }

        guard let url = URL(string: LSLP.baseURL + "v1/\(imageURL)") else {return}
        imageView.kf.setImage(
        with: url,
        placeholder: UIImage.noBookImage,
        options: [.transition(.fade(1.2)), .requestModifier(modifier)]
        )
    }
    func fetchPrfileImage(imageView: UIImageView, imageURL: String?) {
        if let url = imageURL {
            let modifier = AnyModifier { request in
                var req = request
                req.addValue(UserManager.shared.token, forHTTPHeaderField: BaseHeader.authorization.rawValue)
                req.addValue(LSLP.key, forHTTPHeaderField: BaseHeader.sesacKey.rawValue)
                return req
            }

            guard let realUrl = URL(string: LSLP.baseURL + "v1/\(url)") else {return}
            imageView.kf.setImage(
            with: realUrl,
            placeholder: UIImage.noBookImage,
            options: [.transition(.fade(1.2)), .requestModifier(modifier)]
            )
        } else {
            imageView.image = UIImage(named: ProfileImage.randomImage)
        }
    }
}

