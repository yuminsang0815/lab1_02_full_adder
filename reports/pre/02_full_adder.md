# 실험 전 레포트: 전가산기

작성일 2026-09-19.

## 목적과 예상값

세 입력 `a,b,cin`에 대해 반가산기 2개와 OR 게이트를 계층 연결하여 1비트 덧셈의 합 `s`와 올림수 `cout`을 구합니다. 포트는 모두 1비트이며 top은 `full_adder`입니다. 산술 관계는 $a + b + cin = 2 \times cout + s$입니다.

| a | b | cin | cout | s |
|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 0 | 1 |
| 0 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 | 1 |

## 환경과 입력 파일

Windows, Git 2.55.0, VS Code 1.136.1, XSim 2026.1을 사용했습니다. 공개 템플릿의 커밋 `740aef5`를 공백이 있는 별도 폴더에 새로 clone했습니다. `LAB1.code-workspace`는 `vivado_2026_1/02_full_adder`를 PROJECT, `common`을 COMMON으로 연결합니다.

[RTL](../../src/full_adder.v), [TB](../../sim/tb_full_adder.sv), [XDC](../../constraints/full_adder.xdc)를 사용했습니다. TB top은 `tb_full_adder`이며 `{a,b,cin}`을 000부터 111까지 10ns씩 순차 증가시킵니다. 각 조합에서 두 출력을 수식 기반 기대값과 비교하고 오류면 `$fatal`로 중단합니다. 8개 검사가 끝난 경우에만 PASS를 출력하고 80ns에 종료합니다.

## 실행과 관찰

VS Code 새 창에서 workspace를 열고 slang-server와 VaporView를 활성화했습니다. 저장 후 Terminal → Run Task...의 Check tools, Simulate를 실행하고 Open waveform으로 VCD를 열었습니다. `a,b,cin,s,cout`을 추가하고 Zoom to Fit와 ns 단위를 선택했습니다.

실제 [VS Code 작업 실행 로그](../../evidence/02/vscode/simulation.txt)에서 `LAB1_PASS full_adder cases=8`과 80ns 종료를 확인했습니다.

| 구간(ns) | a,b,cin | cout,s | 해석 |
|---|---|---|---|
| 0–10 | 000 | 00 | 무입력 상태로 합과 올림수 모두 0 |
| 10–20 | 001 | 01 | cin만 1: 합 1, 올림수 0 |
| 30–40 | 011 | 10 | 1이 두 개: 올림수 1 발생, 합 0 |
| 70–80 | 111 | 11 | 1이 세 개: 올림수 1, 합 1 동시 발생 |

전환 순간 대신 구간 중간에서 커서를 읽었습니다. 파형만 눈으로 맞아 보이는 것에 더해 자동 비교 8건과 정상 종료를 함께 확인했습니다.

## 보드 실험 계획

KEY1(a)=K4, KEY2(b)=N8, KEY3(cin)=N4, LED1(cout)=L4, LED2(s)=M4, LVCMOS33입니다. Vivado에서 같은 TB를 실행한 다음 bit를 생성하고 8개 입력 조합을 실제로 확인합니다. 특히 세 버튼을 모두 누른 111 조건에서 LED1·2가 모두 켜지는 장면을 사진·영상에 담을 계획입니다.