import DataModel from '../viewmodel/DataModel'
import ItemGroupBean from '../common/bean/ItemGroupBean'

@Component
export default struct ToDoItem {
  private content: string
  @Prop isDone: boolean
  @Link itemsGroup: Array<ItemGroupBean>

  @Builder labelIcon(icon) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width(20)
      .height(20)
      .margin(10)
  }

  build() {
    Row() {
      if (this.isDone) {
        this.labelIcon($r('app.media.ic_ok'));
      } else {
        this.labelIcon($r('app.media.ic_default'));
      }
      Text(this.content)
        .fontSize(20)
        .height(50)
        .width('100%')
        .opacity(this.isDone ? 0.4 : 1)
        .decoration({ type: this.isDone ? TextDecorationType.LineThrough : TextDecorationType.None })
    }
    .width('90%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      let toDoItems = this.itemsGroup[0].items
      let doneItems = this.itemsGroup[1].items
      if(this.isDone) {
        let index = doneItems.indexOf(this.content)
        toDoItems.unshift(this.content)
        doneItems.splice(index,1)
      } else {
        let index = toDoItems.indexOf(this.content)
        doneItems.unshift(this.content)
        toDoItems.splice(index,1)
      }
      this.itemsGroup = DataModel.getData()
    })
  }
}