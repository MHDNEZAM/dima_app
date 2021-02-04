class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Free wifi',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Tennis ',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Pool',
      isSelected: true,
    ),
  ];
}
