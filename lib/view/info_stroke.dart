import 'package:flutter/material.dart';

class InfoStroke extends StatelessWidget {
  const InfoStroke({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뇌졸중 정보'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                // 정의 시작
                const Text(
                  '정의',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "뇌졸중이란 뇌의 일부분에 혈액을 공급하는 혈관이 막히거나(뇌경색) 터짐(뇌출혈)으로써 그 부분의 뇌가 손상되어 나타나는 신경학적 증상을 말합니다. 뇌졸중은 뇌혈관 질환과 같은 말이며, 우리나라에서는 흔히 '중풍'이라는 말로도 불립니다.\n\n뇌졸중은 크게 두 가지로 나눌 수 있습니다.\n첫째는 혈관이 막힘으로써 혈관에 의해 혈액을 공급받던 뇌의 일부가 손상되는 것인데, 이를 뇌경색(Infarction)이라고 합니다. 허혈성 뇌졸중(Iscemic stroke), 경색성 뇌졸중이라고도 불립니다.\n둘째는 뇌혈관이 터짐으로써 뇌 안에 피가 고여 그 부분의 뇌가 손상당한 것으로, 뇌출혈(Hemorrhage) 또는 출혈성 뇌졸중(Hemorrhagic stroke)이라고 합니다. 서양에서는 전자가 후자보다 3배 이상 많으며, 우리나라에서도 허혈성 뇌졸중이 약 85% 정도로 출혈성 뇌졸중보다 더 많은 것으로 알려져 있습니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 정의 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 원인 시작
                const Text(
                  '원인',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "성인의 뇌혈관 질환을 원인에 따라 분류하면 다음과 같습니다.\n① 죽상동맥경화성 혈전증\n② 색전증\n③ 고혈압성 뇌 내 출혈\n④ 동맥류\n⑤ 혈관 기형(vascular malformation)\n⑥ 동맥염(arteritis)\n⑦ 혈액 질환(blood dyscrasia)\n⑧ 모야모야병(Moyamoya disease0",
                  style: TextStyle(fontSize: 20),
                ),
                // 원인 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 증상 시작
                const Text(
                  '증상',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "우리의 뇌는 수없이 다양한 기능을 하고 있습니다. 뇌혈관이 막히거나 터져서 뇌 일부분이 죽으면 이 부분이 담당하던 기능에 장애가 옵니다. 이것이 곧 뇌졸중의 증상입니다. 비교적 흔한 뇌졸중의 증상은 다음과 같습니다.\n① 반신 마비\n팔과 다리를 움직이게 하는 운동 신경은 대뇌에서 내려오다가 뇌간의 아랫부분에서 교차합니다. 따라서 한쪽 뇌에 이상이 생기면 대개는 그 반대쪽에 마비가 옵니다. 뇌간 뇌졸중이 생기면 사지가 모두 마비되기도 합니다.\n② 반신 감각 장애\n감각 신경도 운동 신경과 마찬가지로 교차하여 올라갑니다. 따라서 손상된 뇌의 반대쪽 얼굴, 팔, 다리에 감각 장애가 생깁니다. 이는 대개 반신 마비와 같이 옵니다. 감각 이상이 심해진 경우라면 몹시 불쾌하게 저리거나 아플 수 있습니다.\n③ 언어 장애(실어증)\n정신이 명료한데도 갑자기 말을 잘하지 못하거나 남의 말을 이해하지 못합니다. 90% 이상 사람들의 언어 중추는 좌측 대뇌에 있으므로, 좌측 대뇌에 뇌졸중이 오면 우측 반신 마비와 함께 실어증이 나타날 수 있습니다. 병변의 위치에 따라 글을 못 읽거나 못 쓸 수도 있습니다.\n④ 발음 장애(구음 장애)\n말을 하거나 알아들을 수는 있지만, 혀, 목구멍, 입술 등의 근육이 마비되어 정확한 발음을 할 수 없습니다. 음식을 삼킬 때 장애가 동반되기도 합니다.\n⑤ 운동 실조\n마비되지는 않았지만, 손발이 마음대로 조절되지 않습니다. 걸을 때 자꾸 한쪽으로 쏠려 넘어집니다.\n⑥ 시야, 시력 장애\n갑자기 한쪽 눈이 안 보이거나 시야의 한 귀퉁이가 어둡게 보입니다. 후두엽(대뇌의 가장 뒷부분)에 뇌졸중이 생기면 반대쪽 시야에서 증상이 나타납니다.\n⑦ 복시\n한 물체가 명료하게 보이지 않고 두 개로 겹쳐 보일 수 있습니다. 뇌간 뇌졸중이 생기면 이러한 증상이 나타날 수 있습니다.\n⑧ 연하 장애\n음식물을 잘 삼키지 못하고 사레가 잘 듭니다. 때로는 침을 삼키지 못하여 침을 흘리곤 합니다.\n⑨ 치매\n대개 두 번 이상의 반복적인 뇌졸중이 생기면 기억력, 판단력 등 지적 능력이 떨어집니다. 동작이 서툴러지고 대소변도 잘 못 가리게 됩니다. 감정 조절이 잘되지 않아 괜히 울거나 쓸데없이 웃을 수 있습니다.\n⑩ 어지럼증\n특히 뇌간 뇌졸중인 경우 어지럼증이 잘 나타납니다. 흔히 다른 신경학적 증세를 동반합니다. 다른 신경학적 징후 없이 세상이 빙빙 돌고 메스껍고 토할 것 같다가 곧 좋아지는 증상은 뇌졸중보다는 내이의 가벼운 질환일 가능성이 큽니다. 그러나 일반인들은 이를 쉽게 구별하기 어렵기 때문에 신경과 전문의의 세심한 진찰이 필요합니다.\n⑪ 의식 장애\n뇌졸중의 정도가 심한 경우 또는 뇌간 뇌졸중인 경우 의식 장애가 나타납니다. 가장 심각한 의식 장애의 상태는 혼수상태입니다. 이런 경우 아무리 자극을 주어도 환자가 깨지 못하며, 대체로 예후가 매우 불량합니다.\n⑫ 식물인간 상태\n심한 뇌졸중에 의해 혼수상태에 놓였다가 생명을 건졌다 하더라도 식물인간 상태로 남는 경우가 있습니다. 눈도 뜨고 잠도 자지만 인식 능력이 없어서 사람 구실을 하지 못하고 오랫동안 누워 지내게 됩니다. 의식은 깨어나 인식은 할 수 있지만, 심한 언어 장애, 완전 사지 마비로 꼼짝없이 누워 지내야 하는 경우도 있습니다(감금 증후군 : Locked in syndrome).\n⑬ 두통\n두통은 뇌경색보다는 뇌출혈일 때 더 많이 나타납니다. 특히 뇌동맥류 파열에 의한 지주막하 출혈의 경우, 난생처음 경험하는 극심한 두통이 갑자기 발생하며, 의식을 잃기도 합니다. 일반적으로 수년 이상 지속되는 만성적인 또는 간헐적인 두통의 원인은 뇌졸중이 아닙니다. 그러나 평소의 두통과 그 강도와 양상이 달라졌을 때는 세심한 진찰이 필요합니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 증상 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 주의사항 시작
                const Text(
                  '주의사항',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "평소 위험 인자가 있거나 뇌혈관에 손상이 있는 환자는 위험 인자를 잘 관리하면 정상인처럼 생활할 수 있습니다. 그러나 다음과 같은 상황은 뇌졸중을 촉발시킬 수 있으므로 주의해야 합니다.\n① 과도한 음주\n② 갑작스럽게 추운 곳에 노출되는 것\n③ 심한 스트레스\n④ 지나치게 심한 운동, 과로, 탈수\n이 밖에 혈압이 몹시 높거나 동맥류가 있는 사람이 대변을 볼 때 너무 무리하게 힘을 주거나 지나치게 흥분하면 뇌출혈, 지주막하 출혈을 일으킬 수 있습니다. 한편 머리를 다친지 얼마 뒤에 뇌출혈이 생기는 경우도 보고되었습니다. 혈관 상태가 매우 나쁘거나 고령이라면 탈수 상태에서 뇌졸중이 유발되는 경우가 있습니다. 이런 사람들은 목욕을 너무 오래 하거나 더운 곳에서 탈진할 정도로 일하는 것을 삼가야 합니다.\n어떤 사람들은 자신에게 뇌졸중이 발생했는지조차 인식하지 못하기도 합니다. 하지만 대부분의 뇌졸중 환자에게는 지속적인 언어 장애, 기능 마비 등 많은 문제가 찾아옵니다. 뇌졸중은 장애의 가장 큰 원인입니다. 살아남은 3명 중 1명은 영원히 장애를 안고 살아야 하고, 그보다 더 많은 사람들은 오랜 기간 동안 치료를 해야 합니다. 우리는 작은 습관 하나를 바꾸는 것만으로 뇌졸중을 예방할 수 있습니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 주의사항 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 예방방법 시작
                const Text(
                  '뇌졸중을 예방하는 11가지 방법',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "① 혈압을 조절해라\n② 담배를 피우지 말아라\n③ 적당한 체중을 유지해라\n④ 더 활동적으로 생활해라\n⑤ 꾸준히 심방세동을 확인하고 관리해라 \n⑥ 일과성 뇌허혈 발작이 일어났을 때 더욱더 치료에 주의를 기울여라 \n⑦ 빈혈과 같은 혈액순환 문제를 관리해라\n⑧ 당과 콜레스테롤을 관리해라\n⑨ 술을 조금만 마셔라\n⑩ 저염분, 고칼륨 식사 습관을 가져라 \n⑪ 뇌졸중의 경고 증상에 주의해라",
                  style: TextStyle(fontSize: 20),
                ),
                // 예방방법 끝
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}