from langgraph.graph import StateGraph
from app.agent.state import AgentState

from app.agent.nodes.language_node import language_node
from app.agent.nodes.intent_node import intent_node
from app.agent.nodes.risk_node import risk_node
from app.agent.nodes.decision_node import decision_node
from app.agent.nodes.llm_node import llm_node
from app.agent.nodes.tts_node import tts_node

graph = StateGraph(AgentState)

graph.add_node("language", language_node)
graph.add_node("intent", intent_node)
graph.add_node("risk", risk_node)
graph.add_node("decision", decision_node)
graph.add_node("llm", llm_node)
graph.add_node("tts", tts_node)

graph.set_entry_point("language")
graph.add_edge("language", "intent")
graph.add_edge("intent", "risk")
graph.add_edge("risk", "decision")
graph.add_edge("decision", "llm")
graph.add_edge("llm", "tts")

agent = graph.compile()
