from app.content.pregnancy_weeks import PREGNANCY_WEEKS
from app.content.postpartum_weeks import POSTPARTUM_WEEKS
from app.content.traditional_tips import PREGNANCY_TIPS, POSTPARTUM_TIPS
from app.content.recipes import PREGNANCY_RECIPES, POSTPARTUM_RECIPES
from random import choice

def generate_dadi_reply(
    message: str,
    mother_stage: str,
    week_number: int,
    language: str,
    intent: str,
    strategy: str
) -> str:
    """
    Generates a Dadi-style response using:
    - agent decision (strategy)
    - stage + week data
    - cultural tone
    - intent-specific content
    """

    # 1️⃣ Escalation: ALWAYS override everything
    if strategy == "escalate":
        return (
            "Beta, yeh thoda serious lag raha hai. "
            "Kripya turant doctor ya hospital se sampark karo."
            if language == "hi"
            else
            "This seems serious. Please contact a doctor or hospital immediately."
        )

    # 2️⃣ Emotional reassurance
    if strategy == "reassure":
        return (
            "Mere pyaare beta, jo tum mehsoos kar rahi ho woh bilkul normal aur shuddha bhaavna hai. "
            "Hazaaron saari maayein aisi hi mehsoos karti hain. "
            "Tum ekeli nahi ho, Dadi tumhare saath hai. Bas thoda sabreele raho."
            if language == "hi"
            else
            "My dear child, what you are feeling is so beautifully normal. "
            "Every mother feels this way. You are not alone. "
            "I am right here with you, always."
        )

    # 3️⃣ Recipe intent - provide specific recipes
    if intent == "recipe":
        recipes = PREGNANCY_RECIPES if mother_stage == "pregnancy" else POSTPARTUM_RECIPES
        if recipes:
            recipe = choice(list(recipes.values()))
            if language == "hi":
                return (
                    f"Beta, is hafte ke liye Dadi ka nuskha: {recipe} "
                    f"Yeh tumhare aur tumhare bacche ke liye bahut acha hai."
                )
            else:
                return (
                    f"My dear, Dadi's special recipe for this week: {recipe} "
                    f"This is very good for you and your baby."
                )

    # 4️⃣ Guidance using week-wise data
    if mother_stage == "pregnancy":
        week_data = PREGNANCY_WEEKS.get(week_number, {})
        tip = choice(PREGNANCY_TIPS) if PREGNANCY_TIPS else ""

        if language == "hi":
            return (
                f"Beta, is hafte tumhara baccha badh raha hai. "
                f"{week_data.get('mother', '')} "
                f"Aur yaad rakho, {tip}. "
                "Dadi tumhara khayal rakh rahi hai."
            )
        else:
            return (
                f"This week, your baby is growing. "
                f"{week_data.get('mother', '')} "
                f"Also remember: {tip}. "
                "I am here for you."
            )

    # 5️⃣ Postpartum guidance
    week_data = POSTPARTUM_WEEKS.get(week_number, {})
    tip = choice(POSTPARTUM_TIPS) if POSTPARTUM_TIPS else ""

    if language == "hi":
        return (
            f"Beta, sharir ko sambhalne ka yeh samay hai. "
            f"{week_data.get('mother', '')} "
            f"Aaj ka ek chhota sa sujhav: {tip}."
        )
    else:
        return (
            f"This is a time for recovery. "
            f"{week_data.get('mother', '')} "
            f"One small reminder for today: {tip}."
        )
