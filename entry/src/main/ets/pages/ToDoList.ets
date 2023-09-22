import DataModel from '../viewmodel/DataModel'
import ToDoItem from '../view/ToDoItem'
import AddItemDialog from '../view/AddItemDialog'
import { CommonConstants } from '../common/constant/CommonConstant'
import promptAction from '@ohos.promptAction'
import ItemGroupBean from '../common/bean/ItemGroupBean'


@Entry
@Component
struct ToDoList {
  private title: string = '杨镇岳的待办'
  @State isEditMode: boolean = false
  @State itemsGroup: Array<ItemGroupBean> = []

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .backgroundColor('#F1F3F5')
      .width('100%')
      .padding(5)
  }

  aboutToAppear() {
    this.itemsGroup = DataModel.getData()
  }

  // 保存用户输入
  saveItem(item: string) {
    if (item === '') {
      promptAction.showToast({
        message: '不能为空！',
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      })
      return
    }
    // 保存数据
    DataModel.addData(item)
    // 更新targetData刷新页面
    this.itemsGroup = DataModel.getData()
    this.dialogController.close()
  }

  // 添加待办事项弹窗界面
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddItemDialog({
      onClickOk: (value: string): void => this.saveItem(value)
    }),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: 0,
      dy: -16
    },
    customStyle: true,
    autoCancel: false
  })

  build() {
    Column() {
      Column({ space: 10 }) {
        // 标题
        Text(this.title)
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
          .width('100%')
        // 待办数量显示
        Text(`${this.itemsGroup[0].items.length} 条待办`)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .width('100%')
      }
      .margin({
        top: 25,
        left: 30
      })

      // 循环渲染待办事项列表
      List({ space: 20 }) {
        ForEach(this.itemsGroup, group => {
          if (group.items.length !== 0)
          ListItemGroup({
            header: this.itemHead(group.title),
            space: 20
          }) {
            ForEach(group.items, (item) => {
              ListItem() {
                ToDoItem({
                  content: item,
                  isDone: group.isDone,
                  itemsGroup: this.itemsGroup
                })
              }
            })
          }
        })
      }
      .height(600)
      .width('auto')
      .scrollBar(BarState.Auto)
      .sticky(StickyStyle.Header)
      .margin({
        top: 20,
        left: 30,
        bottom:10
      })
      // .gesture(
      //   GestureGroup(GestureMode.Exclusive,
      //     LongPressGesture()
      //       .onAction(() => {
      //         if (!this.isEditMode) {
      //           this.isEditMode = true; //进入编辑模式
      //         }
      //       })
      //   )
      // )

      // 添加按钮
      Button('+', { type: ButtonType.Circle, stateEffect: true })
        .fontSize(50)
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .width(70)
        .position({
          x: 260,
          y: 620
        })
        .onClick(() => {
          this.dialogController.open()
        })

      // 删除按钮
      // if(this.isEditMode) {
      //   Button('删除').operateButtonStyle('#E84026')
      // }
    }
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Extend(Button) function operateButtonStyle(color) {
  .width('156vp')
  .height('40vp')
  .fontSize('16fp')
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor('#0D182431')
}
