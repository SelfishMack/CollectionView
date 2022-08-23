//
//  MyCollectionView.swift
//  CollectionView
//
//  Created by Владимир on 30.06.2022.
//

import UIKit

class MyCollectionView: UIViewController {
    
    // Инициализируем колекшнвью
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    // Устанавливем константы
    private enum LayoutConstant {
        // Константа отступа от ячейки
        static let spacing: CGFloat = 10.0
        // Константа высоты ячейки
        static let itemHeight: CGFloat = 100.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayouts()
    }
    
    // Настраиваем вью
    private func setupView() {
        // Устанавливаем тайтл на вью
        navigationItem.title = "MyCollectionView"
        // Устанавливаем цвет вью
        view.backgroundColor = .white
        // Устанавливаем во вью колекшвью
        view.addSubview(collectionView)
        
        // Инициализируем датасорс - для того, что бы отображать данные
        collectionView.dataSource = self
        // Инициализируем делегат - чтобы колекшн вью могла передавать данные контроллеру
        collectionView.delegate = self
        // Регистрируем ячейку колекшн вью
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }
    
    private func setupLayouts() {
        // Используем Автолаяут для автоматического изменения размеров колекшвью
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // устанавливаем констрэйнты. Привязываем к UIView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: DataSours
extension MyCollectionView: UICollectionViewDataSource {
    // Устанавливаем количество элементов
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    // Конфигурируем ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.blue
        return myCell
    }
}

// MARK: Delegate
extension MyCollectionView: UICollectionViewDelegate {
    // Действие при нажании на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("User tapped on item \(indexPath.row)")
        }
    
}

// MARK: DelegateFlowLayout
extension MyCollectionView: UICollectionViewDelegateFlowLayout {
    // Метод для установки размеров ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    // Функция для установки ширины ячейки
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return floor(finalWidth)
    }
    
    // Функция для устанвоки отсупов между элементами
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    // Расстояние между последовательными в строке
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    // Расстояние между последовательными элементами в столбце
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}
