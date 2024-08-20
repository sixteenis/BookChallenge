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
}

